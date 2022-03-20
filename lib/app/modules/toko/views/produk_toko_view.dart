import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_item.dart';
import 'package:yo_kasir/app/modules/toko/controllers/toko_controller.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/helper.dart';
import 'package:yo_kasir/config/theme.dart';

class ProdukTokoView extends GetView<TokoController> {
  final namaProduct = TextEditingController();
  final deskripsiProduct = TextEditingController();
  final hargaProduct = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk'),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                controller.isAddProduct.toggle();
              },
              icon: Icon(
                controller.isAddProduct.isFalse ? Icons.add : Icons.close,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isAddProduct.isFalse ? _listItem() : _addView(),
      ),
    );
  }

  Widget _listItem() {
    return StreamBuilder<QuerySnapshot>(
      stream: tokoDb
          .doc(controller.tokoM.value.tokoId)
          .collection("produk-toko")
          .snapshots(),
      builder: (_, s) {
        if (!s.hasData) {
          return ListTile();
        }
        return Padding(
          padding: paddingList,
          child: ListView.builder(
            itemCount: s.data!.docs.length,
            itemBuilder: (_, i) {
              DocumentSnapshot doc = s.data!.docs[i];
              ItemModel item = ItemModel.doc(doc);
              return Card(
                color: primaryColorAccent,
                elevation: 0.5,
                child: ListTile(
                  title: Text(item.namaItem!.capitalize!),
                  subtitle: Text(item.deskripsi!),
                  trailing: Text(Helper.rupiah.format(item.harga)),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _addView() {
    return Padding(
      padding: paddingList,
      child: ListView(
        children: [
          TextFormField(
            controller: namaProduct,
            cursorColor: darkText,
            style: TextStyle(
              color: darkText,
            ),
            decoration: InputDecoration(
              hintText: "Nama Produk",
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
            controller: hargaProduct,
            keyboardType: TextInputType.number,
            cursorColor: darkText,
            style: TextStyle(
              color: darkText,
            ),
            decoration: InputDecoration(
              hintText: "Harga",
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
            maxLength: null,
            keyboardType: TextInputType.multiline,
            controller: deskripsiProduct,
            cursorColor: darkText,
            style: TextStyle(
              color: darkText,
            ),
            decoration: InputDecoration(
              hintText: "Deskripsi",
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
          // Card(
          //   color: primaryColorAccent,
          //   elevation: 0,
          //   child: CheckboxListTile(
          //     value: controller.isDiskon.value,
          //     onChanged: (v) {
          //       controller.isDiskon.value = v!;
          //     },
          //     controlAffinity: ListTileControlAffinity.leading,
          //     title: Text("Diskon"),
          //   ),
          // ),
          // SizedBox(
          //   height: Get.size.height * 0.025,
          // ),
          // Visibility(
          //   visible: controller.isDiskon.value,
          //   child: TextFormField(
          //     controller: namaProduct,
          //     cursorColor: darkText,
          //     style: TextStyle(
          //       color: darkText,
          //     ),
          //     decoration: InputDecoration(
          //       hintText: "Diskon",
          //       contentPadding: EdgeInsets.all(20),
          //       filled: true,
          //       fillColor: primaryColorAccent,
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         borderSide: BorderSide(
          //           color: primaryColorAccent,
          //         ),
          //       ),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         borderSide: BorderSide(
          //           color: primaryColorAccent,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(Get.size.width, 50),
            ),
            onPressed: () {
              ItemModel item = ItemModel(
                namaItem: namaProduct.text,
                deskripsi: deskripsiProduct.text,
                harga: int.parse(hargaProduct.text),
              );
              controller.tambahProdukToko(item, controller.tokoM.value.tokoId);
              namaProduct.clear();
              deskripsiProduct.clear();
              hargaProduct.clear();
              controller.isAddProduct.toggle();
            },
            child: Text(
              "Tambah",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
