import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/data/model_profil.dart';
import 'package:yo_kasir/app/modules/toko/controllers/toko_controller.dart';
import 'package:yo_kasir/config/collection.dart';

class PengelolaTokoView extends GetView<TokoController> {
  final myId = Get.find<AppController>().profilModel.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengelola Toko'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.tokoM.value.akses!.length,
          itemBuilder: (_, i) {
            return FutureBuilder<ProfilModel>(
              future: profilDb
                  .doc(controller.tokoM.value.akses![i])
                  .get()
                  .then((value) => ProfilModel.doc(value)),
              builder: (_, sn) {
                if (!sn.hasData) {
                  return ListTile();
                }
                ProfilModel profilModel = sn.data!;
                return ListTile(
                  title: Text(profilModel.nama!.capitalize!),
                  subtitle: Visibility(
                    visible: profilModel.uid == myId,
                    child: Text("Pemilik"),
                  ),
                  trailing: Visibility(
                    visible: profilModel.uid != myId,
                    child: IconButton(
                      onPressed: () {
                        controller.deleteAksesToko(
                          controller.tokoM.value.tokoId,
                          profilModel.uid,
                        );
                      },
                      icon: Icon(Icons.remove),
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
}
