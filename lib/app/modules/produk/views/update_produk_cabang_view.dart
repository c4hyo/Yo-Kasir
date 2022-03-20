import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/modules/produk/controllers/produk_controller.dart';
import 'package:yo_kasir/config/helper.dart';

import '../../../../config/theme.dart';
import '../../../data/model_item.dart';

class UpdateProdukCabangView extends GetView<ProdukController> {
  final myId = Get.find<AppController>().profilModel.uid;
  final namaProduct = TextEditingController();
  final hargaProduct = TextEditingController();
  final deskripsiProduct = TextEditingController();
  final diskon = TextEditingController();
  final qty = TextEditingController();
  @override
  Widget build(BuildContext context) {
    namaProduct.text = controller.produkM.value.namaItem!;
    hargaProduct.text = controller.produkM.value.harga!.toString();
    deskripsiProduct.text = controller.produkM.value.deskripsi!;
    controller.produkDiskon.value = controller.produkM.value.isDiskon!;
    controller.isQty.value = controller.produkM.value.useQty!;
    qty.text = controller.produkM.value.qty.toString();
    diskon.text = controller.produkM.value.diskon.toString();
    controller.dijual.value = controller.produkM.value.dijual ?? false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Produk ${controller.produkM.value.isDiskon}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            SizedBox(
              height: Get.size.height * 0.025,
            ),
            Container(
              padding: paddingList,
              color: secondaryColorAccent,
              child: Text(
                "Hanya pemilik toko yang dapat mengubah data produk, seperti nama, harga dan deskripsi dari sebuah produk",
              ),
            ),
            SizedBox(
              height: Get.size.height * 0.025,
            ),
            TextFormField(
              readOnly: true,
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
              readOnly: true,
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
              readOnly: true,
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
            Obx(
              () => Card(
                color: primaryColorAccent,
                elevation: 0,
                child: CheckboxListTile(
                  value: controller.dijual.value,
                  onChanged: (v) {
                    controller.dijual.value = v!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Dijual"),
                ),
              ),
            ),
            SizedBox(
              height: Get.size.height * 0.025,
            ),
            Obx(
              () => Card(
                color: primaryColorAccent,
                elevation: 0,
                child: CheckboxListTile(
                  value: controller.isQty.value,
                  onChanged: (v) {
                    controller.isQty.value = v!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Banyak Produk"),
                ),
              ),
            ),
            SizedBox(
              height: Get.size.height * 0.025,
            ),
            Obx(
              () => Visibility(
                visible: controller.isQty.value,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: qty,
                  cursorColor: darkText,
                  style: TextStyle(
                    color: darkText,
                  ),
                  decoration: InputDecoration(
                    hintText: "Banyak Produk",
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
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.isQty.value,
                child: SizedBox(
                  height: Get.size.height * 0.025,
                ),
              ),
            ),
            Obx(
              () => Card(
                color: primaryColorAccent,
                elevation: 0,
                child: CheckboxListTile(
                  value: controller.produkDiskon.value,
                  onChanged: (v) {
                    controller.produkDiskon.value = v!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Diskon"),
                ),
              ),
            ),
            SizedBox(
              height: Get.size.height * 0.025,
            ),
            Obx(
              () => Visibility(
                visible: controller.produkDiskon.value,
                child: TextFormField(
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  controller: diskon,
                  cursorColor: darkText,
                  style: TextStyle(
                    color: darkText,
                  ),
                  decoration: InputDecoration(
                    hintText: "Diskon (Maksimal 99)",
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
                  dijual: controller.dijual.value,
                  itemId: controller.produkM.value.itemId,
                  namaItem: namaProduct.text,
                  deskripsi: deskripsiProduct.text,
                  harga: int.parse(hargaProduct.text),
                  isDiskon: controller.produkDiskon.value,
                  useQty: controller.isQty.value,
                  diskon: controller.produkDiskon.isTrue
                      ? int.parse(diskon.text)
                      : 0,
                  qty: controller.isQty.isTrue ? int.parse(qty.text) : 0,
                  hargaDiskon: controller.produkDiskon.isTrue
                      ? Helper.diskon(
                          int.parse(hargaProduct.text),
                          int.parse(diskon.text),
                        )
                      : 0,
                );
                controller.updateProdukCabang(
                  item,
                  controller.tokoM.value.tokoId,
                  controller.cabangM.value.cabangId,
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
