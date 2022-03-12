import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/modules/cabang/bindings/cabang_binding.dart';
import 'package:yo_kasir/app/modules/cabang/controllers/cabang_controller.dart';
import 'package:yo_kasir/app/modules/cabang/views/pengelola_cabang_view.dart';
import 'package:yo_kasir/config/theme.dart';

class PengaturanCabangView extends GetView<CabangController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Cabang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(FontAwesome5.pencil_alt),
              title: Text("Update Informasi Cabang"),
            ),
            ListTile(
              onTap: () {
                Get.to(
                  () => PengelolaCabangView(),
                  arguments: {
                    "toko": controller.tokoM.value,
                    "cabang": controller.cabangM.value
                  },
                  binding: CabangBinding(),
                );
              },
              leading: Icon(Icons.people_alt_outlined),
              title: Text("Pengelola Cabang"),
            ),
          ],
        ),
      ),
    );
  }
}
