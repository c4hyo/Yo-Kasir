import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_transaksi.dart';
import 'package:yo_kasir/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:yo_kasir/config/helper.dart';
import '../../../../config/theme.dart';
import '../../../data/model_item.dart';

class TambahTransaksiView extends GetView<TransaksiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TambahTransaksiView'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Get.size.height * 0.1),
          child: Padding(
            padding: paddingList,
            child: TextFormField(
              onChanged: (v) {
                controller.cari.value = v;
              },
              decoration: InputDecoration(
                hintText: "Cari produk",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: paddingList,
          child: StreamBuilder<QuerySnapshot>(
            stream: controller.produkCabang(
              controller.cari.value,
              cabangId: controller.cabangM.value.cabangId,
              tokoId: controller.tokoM.value.tokoId,
            ),
            builder: (_, s) {
              if (!s.hasData) {
                return ListTile();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: s.data!.docs.length,
                itemBuilder: (_, i) {
                  ItemModel item = ItemModel.doc(s.data!.docs[i]);
                  return _cardProduks(item);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _cardProduks(ItemModel item) {
    return Card(
      color: primaryColorAccent,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.namaItem!.capitalize!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.deskripsi!.capitalizeFirst!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: item.useQty!,
                      child: Text(
                        "Stok : " + item.qty.toString(),
                      ),
                    ),
                    Visibility(
                      visible: item.useQty!,
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    Text(
                      "Harga : " + Helper.rupiah.format(item.harga),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    ProdukTransaksiModel produk = ProdukTransaksiModel(
                      namaProduk: item.namaItem,
                      hargaSatuProduk:
                          item.isDiskon! ? item.hargaDiskon : item.harga,
                      hargaProduk:
                          item.isDiskon! ? item.hargaDiskon : item.harga,
                      isQty: item.useQty,
                      itemId: item.itemId,
                      qtyProduk: 1,
                    );
                    int indexProduk = controller.keranjang.indexWhere(
                        (element) => element.itemId == produk.itemId);
                    if (indexProduk == -1) {
                      controller.keranjang.add(produk);
                      controller.listProduk.add(item);
                      controller.totalHarga.value =
                          controller.totalHarga.value + produk.hargaProduk!;
                    } else {
                      if (item.useQty! == true) {
                        controller.updateQty(indexProduk);
                        controller.totalHarga.value =
                            controller.totalHarga.value + produk.hargaProduk!;
                      }
                      controller.keranjang.refresh();
                    }

                    Get.back();
                  },
                  child: Icon(
                    Icons.add_shopping_cart,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ExpansionTile _cardProduk(ItemModel item) {
    return ExpansionTile(
      title: Text(item.namaItem!.capitalize!),
      subtitle: Text(item.deskripsi!.capitalize!),
      controlAffinity: ListTileControlAffinity.leading,
      iconColor: darkText,
      textColor: darkText,
      initiallyExpanded: false,
      childrenPadding: paddingList,
      children: [
        ListTile(
          title: Text("Harga"),
          trailing: Text(
            Helper.rupiah.format(item.harga),
          ),
        ),
        Visibility(
          visible: item.useQty!,
          child: ListTile(
            title: Text("Qty"),
            trailing: Text(item.qty.toString()),
          ),
        ),
      ],
      trailing: ElevatedButton(
        onPressed: () {
          ProdukTransaksiModel produk = ProdukTransaksiModel(
            namaProduk: item.namaItem,
            hargaSatuProduk: item.isDiskon! ? item.hargaDiskon : item.harga,
            hargaProduk: item.isDiskon! ? item.hargaDiskon : item.harga,
            isQty: item.useQty,
            itemId: item.itemId,
            qtyProduk: 1,
          );
          int indexProduk = controller.keranjang
              .indexWhere((element) => element.itemId == produk.itemId);
          if (indexProduk == -1) {
            controller.keranjang.add(produk);
            controller.listProduk.add(item);
            controller.totalHarga.value =
                controller.totalHarga.value + produk.hargaProduk!;
          } else {
            if (item.useQty! == true) {
              controller.updateQty(indexProduk);
              controller.totalHarga.value =
                  controller.totalHarga.value + produk.hargaProduk!;
            }
            controller.keranjang.refresh();
          }

          Get.back();

          // Get.back();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
