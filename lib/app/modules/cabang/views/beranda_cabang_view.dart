import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/data/model_transaksi.dart';
import 'package:yo_kasir/app/modules/cabang/bindings/cabang_binding.dart';
import 'package:yo_kasir/app/modules/cabang/controllers/cabang_controller.dart';
import 'package:yo_kasir/app/modules/cabang/views/pengaturan_cabang_view.dart';
import 'package:yo_kasir/app/modules/cabang/views/produk_cabang_view.dart';
import 'package:yo_kasir/app/modules/transaksi/bindings/transaksi_binding.dart';
import 'package:yo_kasir/app/modules/transaksi/views/transaksi_cabang_view.dart';
import 'package:yo_kasir/app/routes/app_pages.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/helper.dart';
import '../../../../config/theme.dart';

class BerandaCabangView extends GetView<CabangController> {
  final myId = Get.find<AppController>().profilModel.uid;
  @override
  Widget build(BuildContext context) {
    controller.countTransaksi.bindStream(controller.getTransaksiCount(
        controller.tokoM.value.tokoId, controller.cabangM.value.cabangId));
    controller.pendapatanPerhari.bindStream(controller.getPendapatanCabang(
        controller.tokoM.value.tokoId, controller.cabangM.value.cabangId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColorAccent,
        elevation: 0,
        actions: [
          Visibility(
            visible: myId == controller.tokoM.value.pemilikId,
            child: IconButton(
              onPressed: () {
                Get.to(
                  () => PengaturanCabangView(),
                  arguments: {
                    "cabang": controller.cabangM.value,
                    "toko": controller.tokoM.value
                  },
                  binding: CabangBinding(),
                );
              },
              icon: Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.size.height * 0.5,
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
                      color: secondaryColorAccent,
                    ),
                  ),
                  Container(
                    height: Get.size.width * 0.5,
                    width: Get.size.width,
                    color: secondaryColorAccent,
                    padding: paddingList,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  controller.countTransaksi.value.toString(),
                                  style: TextStyle(
                                    fontSize: Get.size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Text(
                              "Transaksi Hari ini",
                              style: TextStyle(
                                fontSize: Get.size.width * 0.03,
                                fontWeight: FontWeight.w200,
                                color: darkText,
                              ),
                            ),
                            SizedBox(
                              height: Get.size.height * 0.005,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              controller.tokoM.value.namaToko!.capitalize!,
                              style: TextStyle(
                                fontSize: Get.size.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: Get.size.height * 0.015,
                            ),
                            Text(
                              controller.cabangM.value.namaCabang!.capitalize!,
                              style: TextStyle(
                                fontSize: Get.size.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              controller.cabangM.value.telepon!,
                              style: TextStyle(
                                fontSize: Get.size.width * 0.03,
                                fontWeight: FontWeight.w200,
                                color: darkText,
                              ),
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.TRANSAKSI,
                                      arguments: {
                                        "toko": controller.tokoM.value,
                                        "cabang": controller.cabangM.value,
                                      },
                                    );
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: secondaryColorAccent,
                                          radius: Get.size.width * 0.065,
                                          child: Icon(
                                            Icons.calculate,
                                            color: Colors.black87,
                                            size: Get.size.width * 0.065,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Transaksi Sekarang"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _iconHome(FontAwesome.tags, "Produk", () {
                                  Get.to(
                                    () => ProdukCabangView(),
                                    arguments: {
                                      "cabang": controller.cabangM.value,
                                      "toko": controller.tokoM.value
                                    },
                                    binding: CabangBinding(),
                                  );
                                }),
                                _iconHome(FontAwesome.exchange, "Transaksi",
                                    () {
                                  Get.to(
                                    () => TransaksiCabangView(),
                                    arguments: {
                                      "toko": controller.tokoM.value,
                                      "cabangM": controller.cabangM.value
                                    },
                                    binding: TransaksiBinding(),
                                  );
                                }),
                                _iconHome(Icons.bar_chart, "Statistik", () {}),
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
              padding: paddingList,
              child: Text(
                "Daftar Transaksi Hari ini",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: paddingList,
              child: StreamBuilder<QuerySnapshot>(
                stream: transaksiDb
                    .where("cabang_id",
                        isEqualTo: controller.cabangM.value.cabangId)
                    .where("date_group",
                        isEqualTo:
                            DateFormat.yMMMMd("id").format(DateTime.now()))
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                builder: (_, sn) {
                  if (!sn.hasData) {
                    return ListTile();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: sn.data!.docs.length,
                    itemBuilder: (_, i) {
                      TransaksiModel tm = TransaksiModel.doc(sn.data!.docs[i]);
                      return Card(
                        color: secondaryColorAccent,
                        child: ListTile(
                          dense: true,
                          title: Text(tm.transaksiId!),
                          subtitle: Text(Helper.rupiah.format(tm.totalHarga)),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: secondaryColor,
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.DETAIL_TRANSAKSI,
                                  arguments: {"transaksi": tm.transaksiId});
                            },
                            child: Text("Detail"),
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
              backgroundColor: secondaryColorAccent,
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
