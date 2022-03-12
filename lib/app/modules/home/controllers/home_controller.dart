import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../config/collection.dart';

class HomeController extends GetxController {
  gabungToko(String? code, String? myId) async {
    await tokoDb
        .where("kode_toko", isEqualTo: code!.toUpperCase())
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        tokoDb.where("akses", arrayContains: myId).get().then((val) {
          if (val.docs.isEmpty) {
            tokoDb.doc(value.docs[0].id).update({
              "akses": FieldValue.arrayUnion([myId]),
            });
          } else {
            Get.snackbar("Peringatan", "Anda sudah bergabung ke toko");
          }
        });
        Get.back();
      } else {
        Get.snackbar("Kesalahan", "Toko tidak ditemukan");
      }
    });
  }
}
