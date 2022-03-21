import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/modules/produk/controllers/produk_controller.dart';
import 'package:yo_kasir/config/theme.dart';

import '../../../data/model_item.dart';

class UpdateProdukTokoView extends GetView<ProdukController> {
  final namaProduct = TextEditingController();
  final hargaProduct = TextEditingController();
  final deskripsiProduct = TextEditingController();
  @override
  Widget build(BuildContext context) {
    namaProduct.text = controller.produkM.value.namaItem!;
    hargaProduct.text = controller.produkM.value.harga!.toString();
    deskripsiProduct.text = controller.produkM.value.deskripsi!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Produk Toko'),
        centerTitle: true,
      ),
      body: Padding(
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(Get.size.width, 50),
              ),
              onPressed: () {
                ItemModel item = ItemModel(
                  itemId: controller.produkM.value.itemId,
                  namaItem: namaProduct.text,
                  deskripsi: deskripsiProduct.text,
                  harga: int.parse(hargaProduct.text),
                );
                controller.updateProdukToko(
                  item,
                  controller.tokoM.value.tokoId,
                );
                Get.back();
                // controller.isAddProduct.toggle();
              },
              child: Text(
                "Perbarui",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
