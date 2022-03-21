import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yo_kasir/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:yo_kasir/app/routes/app_pages.dart';

import '../../../../config/helper.dart';
import '../../../../config/theme.dart';
import '../../../data/model_transaksi.dart';

class TransaksiCabangView extends GetView<TransaksiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi Cabang'),
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
                            trailing: Visibility(
                              visible:
                                  controller.filterTransaksi.value == "semua",
                              child: Icon(Icons.check),
                            ),
                            onTap: () {
                              controller.filterTransaksi.value = "semua";
                              Get.back();
                            },
                          ),
                          ListTile(
                            title: Text("Lunas"),
                            trailing: Visibility(
                              visible:
                                  controller.filterTransaksi.value == "lunas",
                              child: Icon(Icons.check),
                            ),
                            onTap: () {
                              controller.filterTransaksi.value = "lunas";
                              Get.back();
                            },
                          ),
                          ListTile(
                            title: Text("Belum lunas"),
                            trailing: Visibility(
                              visible: controller.filterTransaksi.value ==
                                  "belum lunas",
                              child: Icon(Icons.check),
                            ),
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
                stream: controller.filterTransaksiCabang(
                  controller.tokoM.value.tokoId,
                  controller.cabangM.value.cabangId,
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
                            Chip(
                                label: Text(tm.dateGroup ==
                                        DateFormat.yMMMMd("id")
                                            .format(DateTime.now())
                                    ? "Hari ini"
                                    : tm.dateGroup!)),
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

  ListTile _infoTransaksi(TransaksiModel tm) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            tm.isLunas! ? Colors.green.shade700 : Colors.red.shade700,
        child: Icon(
          tm.isLunas! ? Icons.check : Icons.refresh,
          color: lightBackground,
        ),
      ),
      title: Text(tm.transaksiId!),
      subtitle: Text(Helper.rupiah.format(tm.totalHarga)),
      trailing: ElevatedButton(
        child: Text("Detail"),
        onPressed: () {
          Get.toNamed(Routes.DETAIL_TRANSAKSI,
              arguments: {"transaksi": tm.transaksiId});
        },
      ),
    );
  }
}
