import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_item.dart';
import 'package:yo_kasir/app/modules/cabang/controllers/cabang_controller.dart';
import 'package:yo_kasir/app/modules/produk/bindings/produk_binding.dart';
import 'package:yo_kasir/app/modules/produk/views/update_produk_cabang_view.dart';
import 'package:yo_kasir/config/helper.dart';
import 'package:yo_kasir/config/theme.dart';

class ProdukCabangView extends GetView<CabangController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produk Cabang ${controller.cabangM.value.namaCabang!.capitalize}',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(Dialog(
                child: Container(
                  padding: paddingList,
                  color: lightBackground,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Informasi"),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red.shade400,
                          child: Icon(
                            Icons.refresh_outlined,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("Produk yang tidak dijual"),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade400,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("Produk yang dijual"),
                      ),
                    ],
                  ),
                ),
              ));
            },
            icon: Icon(Icons.info_outlined),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Get.size.height * 0.1),
          child: Padding(
            padding: paddingList,
            child: TextFormField(
              onChanged: (v) {
                controller.search.value = v;
              },
              decoration: InputDecoration(
                hintText: "Cari produk",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: paddingList,
          child: Column(
            children: [
              ListTile(
                title: Text("Tampilkan Produk"),
                subtitle: Text(controller.dijual.value.capitalize!),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      color: lightBackground,
                      padding: paddingList,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text("Semua"),
                            trailing: Visibility(
                              visible: controller.dijual.value == "semua",
                              child: Icon(Icons.check),
                            ),
                            onTap: () {
                              controller.dijual.value = "semua";
                              Get.back();
                            },
                          ),
                          ListTile(
                            title: Text("Dijual"),
                            trailing: Visibility(
                              visible: controller.dijual.value == "dijual",
                              child: Icon(Icons.check),
                            ),
                            onTap: () {
                              controller.dijual.value = "dijual";
                              Get.back();
                            },
                          ),
                          ListTile(
                            title: Text("Tidak dijual"),
                            trailing: Visibility(
                              visible:
                                  controller.dijual.value == "tidak dijual",
                              child: Icon(Icons.check),
                            ),
                            onTap: () {
                              controller.dijual.value = "tidak dijual";
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: controller.produkCabang(
                  controller.search.value,
                  cabangId: controller.cabangM.value.cabangId,
                  tokoId: controller.tokoM.value.tokoId,
                  dijual: controller.dijual.value,
                ),
                builder: (_, s) {
                  if (!s.hasData) {
                    return ListTile();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: s.data!.docs.length,
                    itemBuilder: (_, i) {
                      ItemModel item = ItemModel.doc(s.data!.docs[i]);
                      if (!item.dijual!) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red.shade400,
                            child: Icon(
                              Icons.refresh_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(item.namaItem!.capitalize!),
                          subtitle: Text(item.deskripsi!),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Get.to(
                                () => UpdateProdukCabangView(),
                                arguments: {
                                  "produk": item,
                                  "toko": controller.tokoM.value,
                                  "cabang": controller.cabangM.value
                                },
                                binding: ProdukBinding(),
                              );
                            },
                            child: Text("Update"),
                          ),
                        );
                      } else {
                        return ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green.shade400,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(item.namaItem!.capitalize!),
                          subtitle: Text(item.deskripsi!),
                          controlAffinity: ListTileControlAffinity.leading,
                          childrenPadding: paddingList,
                          trailing: ElevatedButton(
                            onPressed: () {
                              Get.to(
                                () => UpdateProdukCabangView(),
                                arguments: {
                                  "produk": item,
                                  "toko": controller.tokoM.value,
                                  "cabang": controller.cabangM.value
                                },
                                binding: ProdukBinding(),
                              );
                            },
                            child: Text("Update"),
                          ),
                          iconColor: darkText,
                          textColor: darkText,
                          children: [
                            ListTile(
                              title: Text("Harga"),
                              trailing: Text(
                                Helper.rupiah.format(item.harga),
                                style: TextStyle(
                                  decoration: item.isDiskon!
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  fontStyle: item.isDiskon!
                                      ? FontStyle.italic
                                      : FontStyle.normal,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: item.useQty!,
                              child: ListTile(
                                title: Text("Banyak Produk"),
                                trailing: Text(item.qty.toString()),
                              ),
                            ),
                            Visibility(
                              visible: item.isDiskon!,
                              child: ListTile(
                                title: Text("Diskon"),
                                trailing: Text("${item.diskon!} %"),
                              ),
                            ),
                            Visibility(
                              visible: item.isDiskon!,
                              child: ListTile(
                                title: Text("Harga Diskon"),
                                trailing: Text(
                                    Helper.rupiah.format(item.hargaDiskon)),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
