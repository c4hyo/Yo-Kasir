import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/data/model_cabang.dart';
import 'package:yo_kasir/app/modules/cabang/bindings/cabang_binding.dart';
import 'package:yo_kasir/app/modules/cabang/views/tambah_cabang_view.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/theme.dart';

import '../controllers/cabang_controller.dart';

class CabangView extends GetView<CabangController> {
  final appC = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Cabang'),
        centerTitle: true,
        actions: [
          Visibility(
            visible: appC.profilModel.uid == controller.tokoM.value.pemilikId,
            child: IconButton(
              onPressed: () {
                Get.to(
                  () => TambahCabangView(),
                  arguments: {
                    "toko": controller.tokoM.value,
                    "cabang": controller.cabangM.value,
                  },
                  binding: CabangBinding(),
                );
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: paddingList,
        child: StreamBuilder<QuerySnapshot>(
          stream: tokoDb
              .doc(controller.tokoM.value.tokoId)
              .collection("cabang")
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return ListTile();
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, i) {
                DocumentSnapshot doc = snapshot.data!.docs[i];
                CabangModel cabang = CabangModel.doc(doc);
                return Card(
                  elevation: 0.5,
                  color: primaryColorAccent,
                  child: ListTile(
                    title: Text(cabang.namaCabang!.capitalize!),
                    subtitle: Text(cabang.alamatCabang!.capitalizeFirst! +
                        " ~ (" +
                        cabang.telepon! +
                        ")"),
                    trailing: Visibility(
                      visible: cabang.pengelola!.contains(appC.profilModel.uid),
                      child: appC.profilModel.uid ==
                              controller.tokoM.value.pemilikId
                          ? ElevatedButton(
                              onPressed: () {},
                              child: Text("Hapus"),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                controller.goToberandaCabang(cabang);
                              },
                              child: Text("Masuk"),
                            ),
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
