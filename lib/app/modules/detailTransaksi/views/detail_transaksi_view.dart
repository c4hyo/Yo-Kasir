import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_transaksi.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/helper.dart';

import '../../../../config/theme.dart';
import '../controllers/detail_transaksi_controller.dart';

class DetailTransaksiView extends GetView<DetailTransaksiController> {
  final pembayaran = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi View'),
        centerTitle: true,
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            StreamBuilder<TransaksiModel>(
              stream: transaksiDb
                  .doc(controller.transaksiId.value)
                  .snapshots()
                  .map((value) => TransaksiModel.doc(value)),
              builder: (_, transaksi) {
                if (!transaksi.hasData) {
                  return Text("");
                }
                TransaksiModel tm = transaksi.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Text("Id Transaksi"),
                      subtitle: Text(tm.transaksiId!),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Text("Tanggal"),
                      subtitle: Text(Helper.date(tm.createdAt)),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Text("Status"),
                      subtitle:
                          tm.isLunas! ? Text("Lunas") : Text("Belum lunas"),
                    ),
                    ListTile(
                      title: Text("Produk terjual "),
                      trailing: FutureBuilder<int>(
                          future: transaksiDb
                              .doc(controller.transaksiId.value)
                              .collection("item-terjual")
                              .get()
                              .then((value) => value.docs.length),
                          builder: (_, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("1");
                            }
                            return Text(snapshot.data!.toString());
                          }),
                    ),
                    Divider(
                      color: darkText,
                      thickness: 1,
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future: transaksiDb
                          .doc(controller.transaksiId.value)
                          .collection("item-terjual")
                          .get(),
                      builder: (_, item) {
                        if (!item.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: item.data!.docs.length,
                          itemBuilder: (_, i) {
                            ProdukTransaksiModel ptm =
                                ProdukTransaksiModel.doc(item.data!.docs[i]);
                            return Column(
                              children: [
                                ListTile(
                                  leading: Text("${i + 1}"),
                                  dense: true,
                                  title: Text(ptm.namaProduk!.capitalize!),
                                  trailing: Visibility(
                                    child: Text(ptm.qtyProduk.toString()),
                                    visible: ptm.isQty!,
                                  ),
                                  subtitle: Text(
                                    Helper.rupiah.format(ptm.hargaProduk),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Divider(
                      color: darkText,
                      thickness: 1,
                    ),
                    tm.isLunas!
                        ? Column(
                            children: [
                              ListTile(
                                title: Text("Total Harga"),
                                trailing: Text(
                                  Helper.rupiah.format(tm.totalHarga),
                                ),
                              ),
                              ListTile(
                                title: Text("Pembayaran"),
                                trailing: Text(
                                  Helper.rupiah.format(tm.pembayaran),
                                ),
                              ),
                              ListTile(
                                title: Text("Kembalian"),
                                trailing: Text(
                                  Helper.rupiah.format(tm.kembalian),
                                ),
                              ),
                            ],
                          )
                        : Obx(
                            () => Column(
                              children: [
                                ListTile(
                                  title: Text("Total Harga"),
                                  trailing: Text(
                                    Helper.rupiah.format(tm.totalHarga),
                                  ),
                                ),
                                ListTile(
                                  title: Text("Pembayaran"),
                                  trailing: Text(
                                    Helper.rupiah
                                        .format(controller.bayar.value),
                                  ),
                                ),
                                ListTile(
                                  title: Text("Kembalian"),
                                  trailing: Text(
                                    Helper.rupiah.format(
                                        (controller.bayar.value -
                                            tm.totalHarga!)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Visibility(
                      visible: !tm.isLunas!,
                      child: TextFormField(
                        controller: pembayaran,
                        onChanged: (v) {
                          controller.bayar.value = int.parse(v);
                        },
                        keyboardType: TextInputType.number,
                        cursorColor: darkText,
                        style: TextStyle(
                          color: darkText,
                        ),
                        decoration: InputDecoration(
                          hintText: "Bayar Sekarang",
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: primaryColorAccent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColorAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColorAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !tm.isLunas!,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.bayar.value == 0) {
                              Get.snackbar("Peringatan!",
                                  "Belum memasukan nominal pembayaran");
                            } else {
                              if ((controller.bayar.value - tm.totalHarga!) <
                                  0) {
                                Get.snackbar(
                                  "Peringatan!",
                                  "Pembayaran kurang ${Helper.rupiah.format((controller.bayar.value - tm.totalHarga!).abs())}",
                                );
                              } else {
                                transaksiDb
                                    .doc(controller.transaksiId.value)
                                    .update({
                                  "is_lunas": true,
                                  "pembayaran": controller.bayar.value,
                                  "kembalian":
                                      controller.bayar.value - tm.totalHarga!,
                                });
                              }
                            }
                          },
                          child: Text("Bayar Sekarang"),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
