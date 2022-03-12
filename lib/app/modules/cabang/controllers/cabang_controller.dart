import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_cabang.dart';
import 'package:yo_kasir/app/modules/toko/controllers/toko_controller.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/helper.dart';

import '../../../data/model_toko.dart';
import '../bindings/cabang_binding.dart';
import '../views/beranda_cabang_view.dart';

class CabangController extends GetxController {
  final tokoM = TokoModel().obs;
  final cabangM = CabangModel().obs;
  final countProduk = 0.obs;

  goToberandaCabang(CabangModel cabang) {
    cabangM.value = cabangM(cabang);
    Get.to(
      () => BerandaCabangView(),
      arguments: {
        "toko": tokoM.value,
        "cabang": cabang,
      },
      binding: CabangBinding(),
    );
  }

  tambahCabang(TokoModel toko, CabangModel cabang, String? myId) async {
    await tokoDb.doc(toko.tokoId).collection("cabang").add({
      "nama_cabang": cabang.namaCabang,
      "alamat_cabang": cabang.alamatCabang,
      "kode_cabang": Helper.generateCode(),
      "pengelola": cabang.pengelola,
      "telepon": cabang.telepon,
    }).then((value) async {
      await tambahProdukCabang(toko.tokoId, value.id);
    });
    int getCountCabang = await tokoDb
        .doc(toko.tokoId)
        .collection("cabang")
        .get()
        .then((value) => value.docs.length);
    await tokoDb.doc(toko.tokoId).update({
      "cabang": getCountCabang,
    });
    tokoM.update((val) {
      val!.cabang = getCountCabang;
    });
    Get.find<TokoController>().tokoM.update((val) {
      val!.cabang = getCountCabang;
    });
  }

  tambahProdukCabang(String? tokoId, String? cabangId) async {
    final getDataProduk =
        await tokoDb.doc(tokoId).collection("produk-toko").get();
    getDataProduk.docs.forEach((element) async {
      await tokoDb
          .doc(tokoId)
          .collection("cabang")
          .doc(cabangId)
          .collection("produk-cabang")
          .add({
        "harga": element['harga'],
        "nama": element['nama'],
        "deskripsi": element['deskripsi'],
        "is_diskon": element['is_diskon'],
        "diskon": element["diskon"],
        "qty": element["qty"],
        "harga_diskon": element["harga_diskon"],
        "kategori_id": element["kategori_id"],
      });
    });
  }

  tambahPengelolaCabang(String? tokoId, String? cabangId, String? uid) async {
    await tokoDb.doc(tokoId).collection("cabang").doc(cabangId).update({
      "pengelola": FieldValue.arrayUnion([uid]),
    });
    cabangM.update((val) {
      val!.pengelola!.add(uid);
    });
  }

  hapusPengelolaCabang(String? tokoId, String? cabangId, String? uid) async {
    cabangM.update((val) {
      val!.pengelola!.removeWhere((element) => element == uid);
    });
    await tokoDb.doc(tokoId).collection("cabang").doc(cabangId).update({
      "pengelola": FieldValue.arrayRemove([uid]),
    });
  }

  Stream<int> getCountProduk(String? tokoId, String? cabangId) {
    return tokoDb
        .doc(tokoId)
        .collection("cabang")
        .doc(cabangId)
        .collection("produk-cabang")
        .snapshots()
        .map((event) => event.docs.length);
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
