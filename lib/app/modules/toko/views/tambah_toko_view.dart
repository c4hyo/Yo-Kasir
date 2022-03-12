import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/data/model_toko.dart';
import 'package:yo_kasir/app/modules/toko/controllers/toko_controller.dart';

import '../../../../config/theme.dart';

class TambahTokoView extends GetView<TokoController> {
  final namaToko = TextEditingController();
  final alamatToko = TextEditingController();
  final teleponToko = TextEditingController();
  final myId = Get.find<AppController>().profilModel.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Toko'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (alamatToko.text.isNotEmpty ||
                  namaToko.text.isNotEmpty ||
                  teleponToko.text.isNotEmpty) {
                TokoModel toko = TokoModel(
                  akses: [myId],
                  alamatToko: alamatToko.text,
                  cabang: 0,
                  namaToko: namaToko.text,
                  pemilikId: myId,
                  telepon: teleponToko.text,
                );
                controller.tambahToko(toko);
                Get.back();
              } else {
                Get.snackbar("Error", "Form harus di isi semua");
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            TextFormField(
              controller: namaToko,
              cursorColor: darkText,
              style: TextStyle(
                color: darkText,
              ),
              decoration: InputDecoration(
                hintText: "Nama Toko",
                contentPadding: EdgeInsets.all(20),
                filled: true,
                fillColor: primaryColorAccent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: primaryColorAccent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: primaryColorAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.size.height * 0.025,
            ),
            TextFormField(
              controller: alamatToko,
              cursorColor: darkText,
              style: TextStyle(
                color: darkText,
              ),
              decoration: InputDecoration(
                hintText: "Alamat Toko",
                contentPadding: EdgeInsets.all(20),
                filled: true,
                fillColor: primaryColorAccent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: primaryColorAccent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: primaryColorAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.size.height * 0.025,
            ),
            TextFormField(
              controller: teleponToko,
              keyboardType: TextInputType.number,
              cursorColor: darkText,
              style: TextStyle(
                color: darkText,
              ),
              decoration: InputDecoration(
                hintText: "Telepon Toko",
                contentPadding: EdgeInsets.all(20),
                filled: true,
                fillColor: primaryColorAccent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: primaryColorAccent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: primaryColorAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
