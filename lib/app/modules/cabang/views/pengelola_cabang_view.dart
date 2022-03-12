import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/data/model_profil.dart';
import 'package:yo_kasir/app/modules/cabang/controllers/cabang_controller.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/theme.dart';

class PengelolaCabangView extends GetView<CabangController> {
  final myId = Get.find<AppController>().profilModel.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengelola Cabang '),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: paddingList,
                  color: lightBackground,
                  child: getListAkses(),
                ),
              );
            },
            icon: Icon(Icons.person_add_alt),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.cabangM.value.pengelola!.length,
          itemBuilder: (_, i) {
            return FutureBuilder<ProfilModel>(
              future: profilDb
                  .doc(controller.cabangM.value.pengelola![i])
                  .get()
                  .then((value) => ProfilModel.doc(value)),
              builder: (_, s) {
                if (!s.hasData) {
                  return ListTile();
                }
                ProfilModel profil = s.data!;
                return ListTile(
                  title: Text(profil.nama!.capitalize!),
                  subtitle: Visibility(
                    visible: controller.tokoM.value.pemilikId == profil.uid,
                    child: Text("Pemilik Toko"),
                  ),
                  trailing: Visibility(
                    visible: controller.tokoM.value.pemilikId != profil.uid,
                    child: IconButton(
                      onPressed: () {
                        controller.hapusPengelolaCabang(
                          controller.tokoM.value.tokoId,
                          controller.cabangM.value.cabangId,
                          profil.uid,
                        );
                      },
                      icon: Icon(Icons.remove_circle),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget getListAkses() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.tokoM.value.akses!.length,
      itemBuilder: (_, i) {
        return FutureBuilder<ProfilModel>(
          future: profilDb
              .doc(controller.tokoM.value.akses![i])
              .get()
              .then((value) => ProfilModel.doc(value)),
          builder: (_, s) {
            if (!s.hasData) {
              return ListTile();
            }
            ProfilModel profil = s.data!;
            return ListTile(
              title: Text(profil.nama!.capitalize!),
              subtitle: Visibility(
                visible: controller.tokoM.value.pemilikId == profil.uid,
                child: Text("Pemilik Toko"),
              ),
              trailing: Visibility(
                visible: controller.tokoM.value.pemilikId != profil.uid,
                child: Visibility(
                  visible:
                      !controller.cabangM.value.pengelola!.contains(profil.uid),
                  child: IconButton(
                    onPressed: () {
                      controller.tambahPengelolaCabang(
                        controller.tokoM.value.tokoId,
                        controller.cabangM.value.cabangId,
                        profil.uid,
                      );
                      Get.back();
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
