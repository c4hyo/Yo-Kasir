import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_toko.dart';
import 'package:yo_kasir/app/modules/toko/bindings/toko_binding.dart';
import 'package:yo_kasir/app/modules/toko/views/cabang_view.dart';

import 'package:yo_kasir/config/theme.dart';

import '../controllers/toko_controller.dart';

class TokoView extends GetView<TokoController> {
  @override
  Widget build(BuildContext context) {
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
                _cardCount(
                  judul: "Total\nCabang",
                  total: 100,
                  warnaAngka: primaryColor,
                  warnaBackground: primaryColorAccent,
                  icon: FontAwesome5.store,
                ),
                _cardCount(
                  judul: "Total\nItem",
                  total: 100,
                  warnaAngka: secondaryColor,
                  warnaBackground: secondaryColorAccent,
                  icon: FontAwesome5.list_alt,
                ),
                _cardCount(
                  judul: "Transaksi\nhari ini",
                  total: 100,
                  warnaAngka: primaryColor,
                  warnaBackground: primaryColorAccent,
                  icon: FontAwesome5.exchange_alt,
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

  Widget _cardCount({
    int? total,
    String? judul,
    Color? warnaBackground,
    Color? warnaAngka,
    IconData? icon,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: warnaBackground,
        elevation: 2,
        child: Container(
          width: Get.size.width * 0.25,
          padding: paddingList,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 35,
                color: warnaAngka,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                total.toString(),
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: warnaAngka,
                ),
              ),
              Text(judul.toString().capitalize!),
            ],
          ),
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
          title: Text("Item yang dijual"),
          leading: Icon(
            FontAwesome.list_alt,
          ),
        ),
        Visibility(
          child: ListTile(
            onTap: () {
              Get.back();
              Get.to(
                () => CabangView(),
                arguments: {"toko": TokoModel()},
                binding: TokoBinding(),
                transition: Transition.rightToLeftWithFade,
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
