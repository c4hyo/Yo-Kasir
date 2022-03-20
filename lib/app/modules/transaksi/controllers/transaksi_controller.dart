import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yo_kasir/app/data/model_item.dart';
import 'package:yo_kasir/app/data/model_transaksi.dart';
import 'package:yo_kasir/app/routes/app_pages.dart';
import 'package:yo_kasir/config/helper.dart';

import '../../../../config/collection.dart';
import '../../../data/model_cabang.dart';
import '../../../data/model_toko.dart';

class TransaksiController extends GetxController {
  final tokoM = TokoModel().obs;
  final cabangM = CabangModel().obs;
  var cari = "".obs;
  final totalHarga = 0.obs;
  final kembalian = 0.obs;
  final bayar = 0.obs;
  final keranjang = <ProdukTransaksiModel>[].obs;
  final listProduk = <ItemModel>[].obs;
  final filterTransaksi = "semua".obs;

  Stream<QuerySnapshot> produkCabang(
    String? search, {
    String? tokoId,
    String? cabangId,
  }) {
    if (search!.isEmpty) {
      return tokoDb
          .doc(tokoId)
          .collection("cabang")
          .doc(cabangId)
          .collection("produk-cabang")
          .where("dijual", isEqualTo: true)
          .snapshots();
    } else {
      return tokoDb
          .doc(tokoId)
          .collection("cabang")
          .doc(cabangId)
          .collection("produk-cabang")
          .where("pencarian", arrayContains: search)
          .where("dijual", isEqualTo: true)
          .snapshots();
    }
  }

  updateQty(int index) {
    keranjang[index].qtyProduk = keranjang[index].qtyProduk! + 1;
    keranjang[index].hargaProduk =
        keranjang[index].hargaSatuProduk! * keranjang[index].qtyProduk!;
  }

  prosesTransaksi(
    TransaksiModel transaksiModel,
  ) async {
    final id = Helper.generateIdTransaksi();
    final date = DateTime.now().toIso8601String();
    await transaksiDb.doc(id).set({
      "toko_id": transaksiModel.tokoId,
      "cabang_id": transaksiModel.cabangId,
      "created_at": date,
      "date_group": DateFormat.yMMMMd("id").format(DateTime.parse(date)),
      "month_group": DateFormat.yMMMM("id").format(DateTime.parse(date)),
      "pembayaran": transaksiModel.pembayaran,
      "total_harga": transaksiModel.totalHarga,
      "kembalian": transaksiModel.kembalian,
      "informasi_pembeli": transaksiModel.informasiPembeli,
      "is_lunas": transaksiModel.isLunas,
    }).then((value) {
      keranjang.forEach((element) async {
        await transaksiDb
            .doc(id)
            .collection("item-terjual")
            .doc(element.itemId)
            .set({
          "nama_produk": element.namaProduk,
          "qty_produk": element.qtyProduk,
          "harga_satu_produk": element.hargaSatuProduk,
          "harga_produk": element.hargaProduk,
          "is_qty": element.isQty,
        });
        if (element.isQty! == true) {
          kurangQty(transaksiModel);
        }
      });
      if (transaksiModel.isLunas == true) {
        Get.back();
        Get.toNamed(Routes.DETAIL_TRANSAKSI, arguments: {"transaksi": id});
      } else {
        Get.back();
      }
    });
  }

  kurangQty(TransaksiModel transaksiModel) async {
    keranjang.forEach((dataKeranjang) {
      tokoDb
          .doc(transaksiModel.tokoId)
          .collection("cabang")
          .doc(transaksiModel.cabangId)
          .collection("produk-cabang")
          .doc(dataKeranjang.itemId)
          .get()
          .then((value) async {
        tokoDb
            .doc(transaksiModel.tokoId)
            .collection("cabang")
            .doc(transaksiModel.cabangId)
            .collection("produk-cabang")
            .doc(dataKeranjang.itemId)
            .update({
          "qty": value['qty'] - dataKeranjang.qtyProduk,
        });
      });
    });
  }

  Stream<QuerySnapshot> filterTransaksiToko(String? tokoId, String? filter) {
    if (filter == "semua") {
      return transaksiDb
          .where("toko_id", isEqualTo: tokoId)
          .orderBy("created_at", descending: true)
          .snapshots();
    } else if (filter == "lunas") {
      return transaksiDb
          .where("toko_id", isEqualTo: tokoId)
          .where("is_lunas", isEqualTo: true)
          .orderBy("created_at", descending: true)
          .snapshots();
    } else if (filter == "belum lunas") {
      return transaksiDb
          .where("toko_id", isEqualTo: tokoId)
          .where("is_lunas", isEqualTo: false)
          .orderBy("created_at", descending: true)
          .snapshots();
    } else {
      return transaksiDb
          .where("toko_id", isEqualTo: tokoId)
          .orderBy("created_at", descending: true)
          .snapshots();
    }
  }

  Stream<QuerySnapshot> filterTransaksiCabang(
      String? tokoId, String? cabangId, String? filter) {
    if (filter == "semua") {
      return transaksiDb
          .where("toko_id", isEqualTo: tokoId)
          .where("cabang_id", isEqualTo: cabangId)
          .orderBy("created_at", descending: true)
          .snapshots();
    } else if (filter == "lunas") {
      return transaksiDb
          .where("toko_id", isEqualTo: tokoId)
          .where("cabang_id", isEqualTo: cabangId)
          .where("is_lunas", isEqualTo: true)
          .orderBy("created_at", descending: true)
          .snapshots();
    } else if (filter == "belum lunas") {
      return transaksiDb
          .where("toko_id", isEqualTo: tokoId)
          .where("cabang_id", isEqualTo: cabangId)
          .where("is_lunas", isEqualTo: false)
          .orderBy("created_at", descending: true)
          .snapshots();
    } else {
      return transaksiDb
          .where("toko_id", isEqualTo: tokoId)
          .where("cabang_id", isEqualTo: cabangId)
          .orderBy("created_at", descending: true)
          .snapshots();
    }
  }

  Future<String> namaCabang(TransaksiModel tm) {
    return tokoDb
        .doc(tm.tokoId)
        .collection("cabang")
        .doc(tm.cabangId)
        .get()
        .then((value) => value.data()!['nama_cabang']);
  }

  @override
  void onInit() {
    super.onInit();
    tokoM.value = tokoM(Get.arguments["toko"] ?? TokoModel());
    cabangM.value = cabangM(Get.arguments["cabang"] ?? CabangModel());
  }

  @override
  void onClose() {
    tokoM.value = tokoM(TokoModel());
    cabangM.value = cabangM(CabangModel());
  }
}
