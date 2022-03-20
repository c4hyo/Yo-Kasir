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
    controller.produkCount
        .bindStream(controller.getProdukCount(controller.tokoM.value.tokoId));
    controller.transaksiCount.bindStream(
        controller.getTransaksiCount(controller.tokoM.value.tokoId));
    controller.pendapatanPerhari
        .bindStream(controller.getPendapatan(controller.tokoM.value.tokoId));
    controller.pendapatanPerBulan.bindStream(
        controller.getPendapatanBulan(controller.tokoM.value.tokoId));
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.size.height * 0.55,
              width: Get.size.width,
              color: lightBackground,
              child: Stack(
                children: [
                  Container(
                    height: Get.size.width * 0.6,
                    width: Get.size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(
                          Get.size.width / 2,
                          Get.size.width * 0.1,
                        ),
                        bottomRight: Radius.elliptical(
                          Get.size.width / 2,
                          Get.size.width * 0.1,
                        ),
                      ),
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: Get.size.width * 0.5,
                    width: Get.size.width,
                    color: primaryColor,
                    padding: paddingList,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                              ),
                            ),
                            SizedBox(
                              height: Get.size.height * 0.025,
                            ),
                            Obx(() => Text(
                                  Helper.rupiah.format(
                                      controller.pendapatanPerhari.value),
                                  style: TextStyle(
                                    fontSize: Get.size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Text(
                              "Pendapatan Hari ini",
                              style: TextStyle(
                                fontSize: Get.size.width * 0.03,
                                fontWeight: FontWeight.w200,
                                color: darkText,
                              ),
                            ),
                            SizedBox(
                              height: Get.size.height * 0.005,
                            ),
                            Obx(() => Text(
                                  Helper.rupiah.format(
                                      controller.pendapatanPerBulan.value),
                                  style: TextStyle(
                                    fontSize: Get.size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Text(
                              "Pendapatan Bulan ini",
                              style: TextStyle(
                                fontSize: Get.size.width * 0.03,
                                fontWeight: FontWeight.w200,
                                color: darkText,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: Get.size.height * 0.025,
                            ),
                            Text(
                              controller.tokoM.value.namaToko!.capitalize!,
                              style: TextStyle(
                                fontSize: Get.size.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              controller.tokoM.value.telepon!,
                              style: TextStyle(
                                fontSize: Get.size.width * 0.03,
                                fontWeight: FontWeight.w200,
                                color: darkText,
                              ),
                            ),
                            SizedBox(
                              height: Get.size.height * 0.015,
                            ),
                            Text(controller.tokoM.value.kodeToko!),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: lightBackground,
                      elevation: 2,
                      child: Container(
                        height: Get.size.width * 0.6,
                        width: Get.size.width * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _iconHome(Icons.store_rounded, "Cabang", () {
                                  Get.toNamed(
                                    Routes.CABANG,
                                    arguments: {"toko": controller.tokoM.value},
                                  );
                                }),
                                _iconHome(FontAwesome.exchange, "Transaksi",
                                    () {
                                  Get.to(
                                    () => TransaksiTokoView(),
                                    arguments: {
                                      "toko": controller.tokoM.value,
                                      "cabang": CabangModel()
                                    },
                                    binding: TransaksiBinding(),
                                  );
                                }),
                                _iconHome(FontAwesome.tags, "Produk", () {
                                  Get.to(
                                    () => ProdukTokoView(),
                                    arguments: {"toko": controller.tokoM.value},
                                    binding: TokoBinding(),
                                  );
                                }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _iconHome(Icons.people_alt, "Pengelola", () {}),
                                _iconHome(Icons.bar_chart, "Statistik", () {}),
                                _iconHome(Icons.settings, "Pengaturan", () {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                "Daftar Cabang",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: StreamBuilder<QuerySnapshot>(
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
                          dense: true,
                          title: Text(cabang.namaCabang!.capitalize!),
                          subtitle: Text(cabang.alamatCabang!.capitalizeFirst! +
                              " ~ (" +
                              cabang.telepon! +
                              ")"),
                          trailing: Visibility(
                            visible: cabang.pengelola!
                                .contains(appC.profilModel.uid),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconHome(IconData? icon, String? judul, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.size.width * 0.2,
        width: Get.size.width * 0.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: primaryColorAccent,
              radius: Get.size.width * 0.065,
              child: Icon(
                icon,
                color: Colors.black87,
                size: Get.size.width * 0.065,
              ),
            ),
            Text(judul!.capitalize!),
          ],
        ),
      ),
    );
  }
}
