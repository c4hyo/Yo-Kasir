import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_item.dart';
import 'package:yo_kasir/config/collection.dart';

import '../../../data/model_cabang.dart';
import '../../../data/model_toko.dart';

class ProdukController extends GetxController {
  final tokoM = TokoModel().obs;
  final cabangM = CabangModel().obs;
  final produkM = ItemModel().obs;
  final produkDiskon = false.obs;
  final isQty = false.obs;
  final dijual = false.obs;

  updateProdukCabang(
      ItemModel? produk, String? tokoId, String? cabangId) async {
    await tokoDb
        .doc(tokoId)
        .collection("cabang")
        .doc(cabangId)
        .collection("produk-cabang")
        .doc(produk!.itemId)
        .update({
      "harga": produk.harga,
      "nama": produk.namaItem,
      "deskripsi": produk.deskripsi,
      "is_diskon": produk.isDiskon,
      "diskon": produk.diskon,
      "qty": produk.qty,
      "harga_diskon": produk.hargaDiskon,
      "kategori_id": "",
      "use_qty": produk.useQty,
      "dijual": produk.dijual,
    });
  }

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
          .snapshots();
    } else {
      return tokoDb
          .doc(tokoId)
          .collection("cabang")
          .doc(cabangId)
          .collection("produk-cabang")
          .where("pencarian", arrayContains: search)
          .snapshots();
    }
  }

  @override
  void onInit() {
    super.onInit();
    produkM.value = produkM(Get.arguments['produk'] ?? ItemModel());
    tokoM.value = tokoM(Get.arguments["toko"] ?? TokoModel());
    cabangM.value = cabangM(Get.arguments["cabang"] ?? CabangModel());
  }

  @override
  void onClose() {
    tokoM.value = tokoM(TokoModel());
    cabangM.value = cabangM(CabangModel());
    produkM.value = produkM(ItemModel());
  }
}
