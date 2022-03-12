import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/modules/cabang/bindings/cabang_binding.dart';
import 'package:yo_kasir/app/modules/cabang/controllers/cabang_controller.dart';
import 'package:yo_kasir/app/modules/cabang/views/pengaturan_cabang_view.dart';

import '../../../../config/theme.dart';
import '../../../../widget/card_count.dart';

class BerandaCabangView extends GetView<CabangController> {
  final myId = Get.find<AppController>().profilModel.uid;
  @override
  Widget build(BuildContext context) {
    controller.countProduk.bindStream(
      controller.getCountProduk(
        controller.tokoM.value.tokoId,
        controller.cabangM.value.cabangId,
      ),
    );
    return Scaffold(
      drawer: Drawer(
        child: _listDrawerCabang(),
      ),
      appBar: AppBar(
        title: Text('Beranda Cabang View'),
        centerTitle: true,
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("Transaksi sekarang"),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: cardCount(
                    judul: "Total\nProduk",
                    total: controller.countProduk.value,
                    warnaAngka: secondaryColor,
                    warnaBackground: secondaryColorAccent,
                    icon: FontAwesome5.list_alt,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: cardCount(
                    judul: "Transaksi\nhari ini",
                    total: 100,
                    warnaAngka: primaryColor,
                    warnaBackground: primaryColorAccent,
                    icon: FontAwesome5.exchange_alt,
                  ),
                ),
              ],
            ),
            Card(
              color: primaryColorAccent,
              elevation: 2,
              child: Container(
                width: Get.size.width * 0.25,
                padding: paddingList,
                child: Row(
                  children: [
                    Text(
                      "Rp.",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "100000",
                          style: TextStyle(
                            fontSize: 35,
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
                  ],
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
          accountName: Text("Nama Toko"),
          accountEmail: Text("Cabang"),
        ),
        ListTile(
          title: Text("Produk yang dijual"),
          leading: Icon(
            FontAwesome.list_alt,
          ),
        ),
        ListTile(
          title: Text("Daftar transaksi"),
          leading: Icon(
            FontAwesome.exchange,
          ),
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
