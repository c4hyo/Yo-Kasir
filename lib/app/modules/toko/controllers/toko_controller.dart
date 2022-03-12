import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_item.dart';
import 'package:yo_kasir/app/data/model_toko.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/helper.dart';

class TokoController extends GetxController {
  final isDiskon = false.obs;
  final isAddProduct = false.obs;
  final tokoM = TokoModel().obs;

  final produkCount = 0.obs;

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
    await tokoDb.doc(tokoId).collection("produk-toko").add({
      "harga": item.harga,
      "nama": item.namaItem,
      "deskripsi": item.deskripsi,
      "is_diskon": false,
      "diskon": 0,
      "qty": 0,
      "harga_diskon": 0,
      "kategori_id": "",
    });
  }

  Stream<int> getProdukCount(String? tokoId) {
    return tokoDb
        .doc(tokoId)
        .collection("produk-toko")
        .snapshots()
        .map((event) => event.docs.length);
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
