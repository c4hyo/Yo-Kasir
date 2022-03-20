import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_transaksi.dart';
import 'package:yo_kasir/app/modules/transaksi/bindings/transaksi_binding.dart';
import 'package:yo_kasir/app/modules/transaksi/views/tambah_transaksi_view.dart';
import 'package:yo_kasir/config/helper.dart';
import '../../../../config/theme.dart';
import '../controllers/transaksi_controller.dart';

class TransaksiView extends GetView<TransaksiController> {
  final pembayaran = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Transaksi'),
        centerTitle: true,
      ),
      body: Obx(
        () => Padding(
          padding: paddingList,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  controller.tokoM.value.namaToko!.capitalize!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  controller.cabangM.value.namaCabang!.capitalize!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing:
                    Text(Helper.tanggal(DateTime.now().toIso8601String())),
              ),
              Visibility(
                visible: controller.keranjang.isNotEmpty,
                child: Divider(
                  color: darkText,
                  thickness: 2,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: controller.keranjang.length + 1,
                itemBuilder: (_, i) {
                  if (i == controller.keranjang.length) {
                    return Column(
                      children: [
                        Visibility(
                          visible: controller.keranjang.isNotEmpty,
                          child: Divider(
                            color: darkText,
                            thickness: 2,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(
                              () => TambahTransaksiView(),
                              arguments: {
                                "toko": controller.tokoM.value,
                                "cabang": controller.cabangM.value,
                              },
                              binding: TransaksiBinding(),
                            );
                            controller.cari.value = "";
                          },
                          child: Text("Tambah Produk"),
                        ),
                      ],
                    );
                  } else {
                    ProdukTransaksiModel produk = controller.keranjang[i];
                    return produk.isQty!
                        ? _produkQty(produk)
                        : _produkNonQty(produk);
                  }
                },
              ),
              Visibility(
                visible: controller.keranjang.isNotEmpty,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Total Harga",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      trailing: Text(
                        Helper.rupiah.format(controller.totalHarga.value),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Pembayaran",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                    ),
                    ListTile(
                      title: Text(
                        "Kembalian",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Text(
                        Helper.rupiah.format(
                          controller.bayar.value - controller.totalHarga.value,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: paddingList,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade700,
                            ),
                            onPressed: () {
                              TransaksiModel tm = TransaksiModel(
                                cabangId: controller.cabangM.value.cabangId,
                                tokoId: controller.tokoM.value.tokoId,
                                isLunas: false,
                                kembalian: (controller.bayar.value -
                                    controller.totalHarga.value),
                                pembayaran: controller.bayar.value,
                                totalHarga: controller.totalHarga.value,
                                informasiPembeli: "",
                              );
                              controller.prosesTransaksi(tm);
                            },
                            child: Text("Bayar Nanti"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (controller.bayar.value != 0) {
                                if ((controller.bayar.value -
                                        controller.totalHarga.value) <
                                    0) {
                                  Get.snackbar(
                                    "Peringatan!",
                                    "Pembayaran kurang ${Helper.rupiah.format((controller.bayar.value - controller.totalHarga.value).abs())}",
                                  );
                                } else {
                                  TransaksiModel tm = TransaksiModel(
                                    cabangId: controller.cabangM.value.cabangId,
                                    tokoId: controller.tokoM.value.tokoId,
                                    isLunas: true,
                                    kembalian: (controller.bayar.value -
                                        controller.totalHarga.value),
                                    pembayaran: controller.bayar.value,
                                    totalHarga: controller.totalHarga.value,
                                    informasiPembeli:
                                        controller.cabangM.value.namaCabang,
                                  );
                                  controller.prosesTransaksi(tm);
                                }
                              } else {
                                Get.snackbar(
                                  "Peringatan!",
                                  "Masukan nominal pembayaran",
                                );
                              }
                            },
                            child: Text(
                              "Bayar Sekarang ",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _produkNonQty(ProdukTransaksiModel produk) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(produk.namaProduk!.capitalize!),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Helper.rupiah.format(produk.hargaProduk),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.shade700,
                ),
                onPressed: () {},
                child: Icon(
                  Icons.delete_outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _produkQty(ProdukTransaksiModel produk) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(produk.namaProduk!.capitalize!),
            SizedBox(
              height: 10,
            ),
            Text(
              Helper.rupiah.format(produk.hargaProduk),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (produk.qtyProduk == 1)
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade800,
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Peringatan!",
                            middleText: "Apakah anda akan menghapus produk ini",
                            cancel: ElevatedButton(
                              onPressed: () {
                                controller.keranjang.removeWhere((element) =>
                                    element.itemId == produk.itemId);
                                controller.totalHarga.value =
                                    controller.totalHarga.value -
                                        produk.hargaProduk!;
                                Get.back();
                              },
                              child: Text("Ya"),
                            ),
                            confirm: ElevatedButton(
                              style: borderButton,
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "Tidak",
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.delete),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent.shade100,
                        ),
                        onPressed: () {
                          if (produk.qtyProduk! > 1) {
                            produk.qtyProduk = produk.qtyProduk! - 1;
                            produk.hargaProduk =
                                produk.hargaSatuProduk! * produk.qtyProduk!;
                            controller.totalHarga.value =
                                controller.totalHarga.value -
                                    produk.hargaSatuProduk!;
                            controller.keranjang.refresh();
                          }
                        },
                        child: Icon(Icons.remove),
                      ),
                Text(produk.qtyProduk.toString()),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade300,
                  ),
                  onPressed: () {
                    if (produk.qtyProduk! ==
                        controller
                            .listProduk[controller.listProduk.indexWhere(
                                (element) => element.itemId == produk.itemId)]
                            .qty) {
                      Get.snackbar("Peringatan !",
                          "Stok barang sudah habis atau perbarui data stok");
                    } else {
                      produk.qtyProduk = produk.qtyProduk! + 1;
                      produk.hargaProduk =
                          produk.hargaSatuProduk! * produk.qtyProduk!;
                      controller.totalHarga.value =
                          controller.totalHarga.value + produk.hargaSatuProduk!;
                      controller.keranjang.refresh();
                    }
                  },
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
