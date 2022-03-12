import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_cabang.dart';
import 'package:yo_kasir/app/modules/cabang/controllers/cabang_controller.dart';
import 'package:yo_kasir/config/theme.dart';

import '../../../controllers/app_controller.dart';

class TambahCabangView extends GetView<CabangController> {
  final namaCabang = TextEditingController();
  final alamatCabang = TextEditingController();
  final teleponCabang = TextEditingController();
  final myId = Get.find<AppController>().profilModel.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Cabang'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (alamatCabang.text.isNotEmpty ||
                  namaCabang.text.isNotEmpty ||
                  teleponCabang.text.isNotEmpty) {
                CabangModel toko = CabangModel(
                    alamatCabang: alamatCabang.text,
                    namaCabang: namaCabang.text,
                    telepon: teleponCabang.text,
                    pengelola: [myId]);
                controller.tambahCabang(controller.tokoM.value, toko, myId);

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
              controller: namaCabang,
              cursorColor: darkText,
              style: TextStyle(
                color: darkText,
              ),
              decoration: InputDecoration(
                hintText: "Nama Cabang",
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
              controller: alamatCabang,
              cursorColor: darkText,
              style: TextStyle(
                color: darkText,
              ),
              decoration: InputDecoration(
                hintText: "Alamat Cabang",
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
              controller: teleponCabang,
              keyboardType: TextInputType.number,
              cursorColor: darkText,
              style: TextStyle(
                color: darkText,
              ),
              decoration: InputDecoration(
                hintText: "Telepon Cabang",
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
