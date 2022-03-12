import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/modules/toko/bindings/toko_binding.dart';
import 'package:yo_kasir/app/modules/toko/views/produk_toko_view.dart';
import 'package:yo_kasir/app/routes/app_pages.dart';

import 'package:yo_kasir/config/theme.dart';

import '../../../../widget/card_count.dart';
import '../controllers/toko_controller.dart';

class TokoView extends GetView<TokoController> {
  @override
  Widget build(BuildContext context) {
    controller.produkCount.bindStream(
      controller.getProdukCount(controller.tokoM.value.tokoId),
    );
    return Scaffold(
      drawer: Drawer(
        child: _listDrawer(),
      ),
      appBar: AppBar(
        title: Text('Nama Toko'),
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
                    () => cardCount(
                      judul: "Total\nCabang",
                      total: controller.tokoM.value.cabang,
                      warnaAngka: primaryColor,
                      warnaBackground: primaryColorAccent,
                      icon: FontAwesome5.store,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: cardCount(
                    judul: "Total\nProduk",
                    total: controller.produkCount.value,
                    warnaAngka: secondaryColor,
                    warnaBackground: secondaryColorAccent,
                    icon: FontAwesome5.list_alt,
                  ),
                ),
                Expanded(
                  flex: 3,
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
            SizedBox(
              height: 10,
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Transaksi terbaru",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text("Cabang X"),
              subtitle: Text("Harga : Rp. 1.200.000 ~ 10 Item"),
              trailing: ElevatedButton(
                style: borderButton,
                onPressed: () {},
                child: Text(
                  "Detail",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
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
          accountName: Text("Nama Toko"),
          accountEmail: Text("Telepon.e"),
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
      ],
    );
  }
}
