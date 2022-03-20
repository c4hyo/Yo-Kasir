import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/modules/cabang/bindings/cabang_binding.dart';
import 'package:yo_kasir/app/modules/cabang/controllers/cabang_controller.dart';
import 'package:yo_kasir/app/modules/cabang/views/pengaturan_cabang_view.dart';
import 'package:yo_kasir/app/modules/cabang/views/produk_cabang_view.dart';
import 'package:yo_kasir/app/modules/transaksi/bindings/transaksi_binding.dart';
import 'package:yo_kasir/app/modules/transaksi/views/transaksi_cabang_view.dart';
import 'package:yo_kasir/app/routes/app_pages.dart';
import 'package:yo_kasir/config/helper.dart';

import '../../../../config/theme.dart';
import '../../../../widget/card_count.dart';

class BerandaCabangView extends GetView<CabangController> {
  final myId = Get.find<AppController>().profilModel.uid;
  @override
  Widget build(BuildContext context) {
    controller.countProduk.bindStream(controller.getCountProduk(
        controller.tokoM.value.tokoId, controller.cabangM.value.cabangId));
    controller.countTransaksi.bindStream(controller.getTransaksiCount(
        controller.tokoM.value.tokoId, controller.cabangM.value.cabangId));
    controller.pendapatanPerhari.bindStream(controller.getPendapatanCabang(
        controller.tokoM.value.tokoId, controller.cabangM.value.cabangId));
    return Scaffold(
      drawer: Drawer(
        child: _listDrawerCabang(),
      ),
      appBar: AppBar(
        title: Text('Beranda Cabang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(
                  Routes.TRANSAKSI,
                  arguments: {
                    "toko": controller.tokoM.value,
                    "cabang": controller.cabangM.value,
                  },
                );
              },
              child: Text("Transaksi sekarang"),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        Get.to(
                          () => ProdukCabangView(),
                          arguments: {
                            "cabang": controller.cabangM.value,
                            "toko": controller.tokoM.value
                          },
                          binding: CabangBinding(),
                        );
                      },
                      child: cardCount(
                        judul: "Total\nProduk",
                        total: controller.countProduk.value,
                        warnaAngka: secondaryColor,
                        warnaBackground: secondaryColorAccent,
                        icon: FontAwesome5.list_alt,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        Get.to(
                          () => TransaksiCabangView(),
                          arguments: {
                            "toko": controller.tokoM.value,
                            "cabangM": controller.cabangM.value
                          },
                          binding: TransaksiBinding(),
                        );
                      },
                      child: cardCount(
                        judul: "Transaksi\nhari ini",
                        total: controller.countTransaksi.value,
                        warnaAngka: primaryColor,
                        warnaBackground: primaryColorAccent,
                        icon: FontAwesome5.exchange_alt,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => Card(
                color: primaryColorAccent,
                elevation: 2,
                child: Container(
                  width: Get.size.width * 0.25,
                  padding: paddingList,
                  child: Column(
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
          ],
        ),
      ),
    );
  }

  Widget _listDrawerCabang() {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: primaryColor),
          accountName: Text(controller.tokoM.value.namaToko!.capitalize!),
          accountEmail: Text(controller.cabangM.value.namaCabang!.capitalize!),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.to(
              () => ProdukCabangView(),
              arguments: {
                "cabang": controller.cabangM.value,
                "toko": controller.tokoM.value
              },
              binding: CabangBinding(),
            );
          },
          title: Text("Produk"),
          leading: Icon(
            FontAwesome.list_alt,
          ),
        ),
        ListTile(
          title: Text("Daftar transaksi"),
          leading: Icon(
            FontAwesome.exchange,
          ),
          onTap: () {
            Get.back();
            Get.to(
              () => TransaksiCabangView(),
              arguments: {
                "toko": controller.tokoM.value,
                "cabangM": controller.cabangM.value
              },
              binding: TransaksiBinding(),
            );
          },
        ),
        Visibility(
          visible: controller.tokoM.value.pemilikId == myId,
          child: ListTile(
            title: Text("Pengaturan cabang"),
            onTap: () {
              Get.back();
              Get.to(
                () => PengaturanCabangView(),
                arguments: {
                  "cabang": controller.cabangM.value,
                  "toko": controller.tokoM.value
                },
                binding: CabangBinding(),
              );
            },
            leading: Icon(
              FontAwesome.cog,
            ),
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
