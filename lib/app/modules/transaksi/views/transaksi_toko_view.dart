import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yo_kasir/app/data/model_transaksi.dart';
import 'package:yo_kasir/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/helper.dart';
import 'package:yo_kasir/config/theme.dart';

class TransaksiTokoView extends GetView<TransaksiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi Toko'),
        centerTitle: true,
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            Obx(
              () => ListTile(
                title: Text(controller.filterTransaksi.value.capitalize!),
                trailing: Icon(
                  Icons.arrow_drop_down,
                ),
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: paddingList,
                      color: lightBackground,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text("Semua"),
                            onTap: () {
                              controller.filterTransaksi.value = "semua";
                              Get.back();
                            },
                          ),
                          ListTile(
                            title: Text("Lunas"),
                            onTap: () {
                              controller.filterTransaksi.value = "lunas";
                              Get.back();
                            },
                          ),
                          ListTile(
                            title: Text("Belum lunas"),
                            onTap: () {
                              controller.filterTransaksi.value = "belum lunas";
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => StreamBuilder<QuerySnapshot>(
                stream: controller.filterTransaksiToko(
                  controller.tokoM.value.tokoId,
                  controller.filterTransaksi.value,
                ),
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
                      if (i == 0) {
                        return Column(
                          children: [
                            Chip(label: Text("Hari ini")),
                            _infoTransaksi(tm),
                          ],
                        );
                      } else {
                        if (tm.dateGroup ==
                            sn.data!.docs[i - 1]['date_group']) {
                          return _infoTransaksi(tm);
                        } else {
                          return Column(
                            children: [
                              Chip(
                                label: Text(tm.dateGroup ==
                                        DateFormat.yMMMMd("id")
                                            .format(DateTime.now())
                                    ? "Hari ini"
                                    : tm.dateGroup!),
                              ),
                              _infoTransaksi(tm),
                            ],
                          );
                        }
                      }
                      // return _infoTransaksi(tm);
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

  ExpansionTile _infoTransaksi(TransaksiModel tm) {
    return ExpansionTile(
      iconColor: darkText,
      textColor: darkText,
      leading: CircleAvatar(
        backgroundColor:
            tm.isLunas! ? Colors.green.shade700 : Colors.red.shade700,
        child: Icon(
          tm.isLunas! ? Icons.check : Icons.refresh,
          color: lightBackground,
        ),
      ),
      title: Text(
        tm.informasiPembeli == "" ? "Produk" : tm.transaksiId!,
      ),
      subtitle: FutureBuilder<String>(
        future: controller.namaCabang(tm),
        builder: (_, cb) {
          if (!cb.hasData) {
            return Text("Cabang: ");
          }
          return Text(cb.data!.capitalize!);
        },
      ),
      trailing: Text(Helper.rupiah.format(tm.totalHarga)),
      children: [
        ListTile(
          title: Text(tm.dateGroup!),
        ),
        ListTile(
          title: Text("Produk terjual :"),
        ),
        FutureBuilder<QuerySnapshot>(
          future:
              transaksiDb.doc(tm.transaksiId).collection("item-terjual").get(),
          builder: (_, s) {
            if (!s.hasData) {
              return ListTile();
            }
            return ListView.builder(
              padding: EdgeInsets.only(left: 10, right: 10),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: s.data!.docs.length,
              itemBuilder: (_, index) {
                ProdukTransaksiModel ptm =
                    ProdukTransaksiModel.doc(s.data!.docs[index]);
                return ListTile(
                  title: Text(ptm.namaProduk!.capitalize!),
                  trailing: Text(ptm.qtyProduk.toString()),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
