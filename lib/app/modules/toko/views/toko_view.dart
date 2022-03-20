import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/data/model_cabang.dart';

import 'package:yo_kasir/app/modules/toko/bindings/toko_binding.dart';
import 'package:yo_kasir/app/modules/toko/views/produk_toko_view.dart';
import 'package:yo_kasir/app/modules/transaksi/bindings/transaksi_binding.dart';
import 'package:yo_kasir/app/modules/transaksi/views/transaksi_toko_view.dart';
import 'package:yo_kasir/app/routes/app_pages.dart';
import 'package:yo_kasir/config/helper.dart';

import 'package:yo_kasir/config/theme.dart';

import '../../../../config/collection.dart';
import '../../../../widget/card_count.dart';

import '../../cabang/bindings/cabang_binding.dart';
import '../../cabang/views/beranda_cabang_view.dart';
import '../controllers/toko_controller.dart';

class TokoView extends GetView<TokoController> {
  final appC = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    controller.produkCount.bindStream(
      controller.getProdukCount(controller.tokoM.value.tokoId),
    );
    controller.transaksiCount.bindStream(
        controller.getTransaksiCount(controller.tokoM.value.tokoId));
    controller.pendapatanPerhari
        .bindStream(controller.getPendapatan(controller.tokoM.value.tokoId));
    return Scaffold(
      drawer: Drawer(
        child: _listDrawer(),
      ),
      appBar: AppBar(
        title: Text(controller.tokoM.value.namaToko!.capitalize!),
        centerTitle: true,
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.CABANG,
                          arguments: {"toko": controller.tokoM.value},
                        );
                      },
                      child: cardCount(
                        judul: "Total\nCabang",
                        total: controller.tokoM.value.cabang,
                        warnaAngka: primaryColor,
                        warnaBackground: primaryColorAccent,
                        icon: FontAwesome5.store,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        Get.to(
                          () => ProdukTokoView(),
                          arguments: {"toko": controller.tokoM.value},
                          binding: TokoBinding(),
                        );
                      },
                      child: cardCount(
                        judul: "Total\nProduk",
                        total: controller.produkCount.value,
                        warnaAngka: secondaryColor,
                        warnaBackground: secondaryColorAccent,
                        icon: FontAwesome5.list_alt,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        controller.getPendapatan(controller.tokoM.value.tokoId);
                      },
                      child: cardCount(
                        judul: "Transaksi\nhari ini",
                        total: controller.transaksiCount.value,
                        warnaAngka: primaryColor,
                        warnaBackground: primaryColorAccent,
                        icon: FontAwesome5.exchange_alt,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: primaryColorAccent,
              elevation: 2,
              child: Container(
                width: Get.size.width * 0.25,
                padding: paddingList,
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        Helper.rupiah
                            .format(controller.pendapatanPerhari.value),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Pendapatan hari ini",
                        style: TextStyle(
                          color: darkText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Daftar Cabang",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: tokoDb
                  .doc(controller.tokoM.value.tokoId)
                  .collection("cabang")
                  .snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return ListTile();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
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
                          visible:
                              cabang.pengelola!.contains(appC.profilModel.uid),
                          child: ElevatedButton(
                            onPressed: () {
                              // controller.goToberandaCabang(cabang);
                              Get.to(
                                () => BerandaCabangView(),
                                arguments: {
                                  "toko": controller.tokoM.value,
                                  "cabang": cabang,
                                },
                                binding: CabangBinding(),
                              );
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
          ],
        ),
      ),
    );
  }

  Widget _listDrawer() {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: primaryColor),
          accountName: Text(controller.tokoM.value.namaToko!.capitalize!),
          accountEmail: Text(controller.tokoM.value.kodeToko.toString()),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.to(
              () => ProdukTokoView(),
              arguments: {"toko": controller.tokoM.value},
              binding: TokoBinding(),
            );
          },
          title: Text("Produk yang dijual"),
          leading: Icon(
            FontAwesome.list_alt,
          ),
        ),
        Visibility(
          child: ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(
                Routes.CABANG,
                arguments: {"toko": controller.tokoM.value},
              );
            },
            title: Text("Cabang"),
            leading: Icon(FontAwesome5.store),
          ),
        ),
        ListTile(
          title: Text("Transaksi"),
          onTap: () {
            Get.back();
            Get.to(
              () => TransaksiTokoView(),
              arguments: {
                "toko": controller.tokoM.value,
                "cabang": CabangModel()
              },
              binding: TransaksiBinding(),
            );
          },
          leading: Icon(
            FontAwesome.exchange,
          ),
        ),
        ListTile(
          title: Text("Pengaturan toko"),
          leading: Icon(
            FontAwesome.cog,
          ),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.back();
          },
          title: Text("Kembali"),
          leading: Icon(
            Icons.arrow_back,
          ),
        ),
      ],
    );
  }
}
