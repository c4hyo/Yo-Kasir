import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yo_kasir/app/data/model_item.dart';
import 'package:yo_kasir/app/data/model_toko.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/helper.dart';

class TokoController extends GetxController {
  final isDiskon = false.obs;
  final isAddProduct = false.obs;
  final tokoM = TokoModel().obs;

  final produkCount = 0.obs;
  final transaksiCount = 0.obs;
  final pendapatanPerhari = 0.obs;
  final pendapatanPerBulan = 0.obs;

  tambahToko(TokoModel toko) async {
    await tokoDb.add({
      "nama_toko": toko.namaToko,
      "alamat_toko": toko.alamatToko,
      "pemilik_id": toko.pemilikId,
      "cabang": toko.cabang,
      "akses": toko.akses,
      "kode_toko": Helper.generateCode(),
      "telepon": toko.telepon,
    });
  }

  tambahProdukToko(ItemModel item, String? tokoId) async {
    final getCabang = await tokoDb.doc(tokoId).collection("cabang").get();
    await tokoDb.doc(tokoId).collection("produk-toko").add({
      "harga": item.harga,
      "nama": item.namaItem,
      "deskripsi": item.deskripsi,
      "is_diskon": false,
      "diskon": 0,
      "qty": 0,
      "harga_diskon": 0,
      "kategori_id": "",
      "use_qty": false,
      "dijual": false,
      "pencarian": Helper.searchCase(
        item.namaItem!.toLowerCase(),
      ),
    }).then((value) async {
      getCabang.docs.forEach((element) async {
        await tokoDb
            .doc(tokoId)
            .collection("cabang")
            .doc(element.id)
            .collection("produk-cabang")
            .doc(value.id)
            .set({
          "harga": item.harga,
          "nama": item.namaItem,
          "deskripsi": item.deskripsi,
          "is_diskon": false,
          "diskon": 0,
          "qty": 0,
          "harga_diskon": 0,
          "kategori_id": "",
          "use_qty": false,
          "dijual": false,
          "pencarian": Helper.searchCase(
            item.namaItem!.toLowerCase(),
          ),
        });
      });
    });
  }

  Stream<int> getProdukCount(String? tokoId) {
    return tokoDb
        .doc(tokoId)
        .collection("produk-toko")
        .snapshots()
        .map((event) => event.docs.length);
  }

  Stream<int> getTransaksiCount(String? tokoId) {
    return transaksiDb
        .where("toko_id", isEqualTo: tokoId)
        .where(
          "date_group",
          isEqualTo: DateFormat.yMMMMd("id").format(DateTime.now()),
        )
        .snapshots()
        .map((event) => event.docs.length);
  }

  Stream<int> getPendapatan(String? tokoId) {
    return transaksiDb
        .where("toko_id", isEqualTo: tokoId)
        .where(
          "date_group",
          isEqualTo: DateFormat.yMMMMd("id").format(DateTime.now()),
        )
        .where("is_lunas", isEqualTo: true)
        .snapshots()
        .map((event) {
      int total = 0;
      event.docs.forEach((element) {
        total += element.data()['total_harga'] as int;
        // print(element);
      });
      return total;
    });
  }

  Stream<int> getPendapatanBulan(String? tokoId) {
    return transaksiDb
        .where("toko_id", isEqualTo: tokoId)
        .where(
          "month_group",
          isEqualTo: DateFormat.yMMMM("id").format(DateTime.now()),
        )
        .where("is_lunas", isEqualTo: true)
        .snapshots()
        .map((event) {
      int total = 0;
      event.docs.forEach((element) {
        total += element.data()['total_harga'] as int;
        // print(element);
      });
      return total;
    });
  }

  deleteAksesToko(String? tokoId, String? uid) async {
    await tokoDb
        .doc(tokoId)
        .collection("cabang")
        .where("pengelola", whereIn: [uid])
        .get()
        .then((value) {
          if (value.docs.isNotEmpty) {
            value.docs.forEach((element) async {
              await tokoDb
                  .doc(tokoId)
                  .collection("cabang")
                  .doc(element.id)
                  .update({
                "pengelola": FieldValue.arrayRemove([uid]),
              });
            });
          }
        });
    await tokoDb.doc(tokoId).update({
      "akses": FieldValue.arrayRemove([uid]),
    });
    tokoM.update((val) {
      val!.akses!.removeWhere((element) => element == uid);
    });
  }

  @override
  void onInit() {
    super.onInit();
    tokoM.value = tokoM(Get.arguments["toko"] ?? TokoModel());
  }

  @override
  void onClose() {
    tokoM.value = tokoM(TokoModel());
  }
}
