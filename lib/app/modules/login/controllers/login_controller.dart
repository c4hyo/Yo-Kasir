import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/data/model_profil.dart';
import 'package:yo_kasir/config/collection.dart';

class LoginController extends GetxController {
  var loading = false.obs;
  var obsecure = true.obs;

  // fungsi login
  login({String? password, String? email}) async {
    loading.value = true;
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email!,
        password: password!,
      ) // fungsi login dari firebase
          .then((value) async {
        // mendapatkan data profil dari database
        return Get.find<AppController>().profilModel =
            await Get.find<AppController>().profilPengguna(value.user!.uid);
      });
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  registrasi(ProfilModel profilModel, String? password) async {
    loading.value = true;

    try {
      UserCredential us = await auth.createUserWithEmailAndPassword(
        email: profilModel.email!,
        password: password!,
      );
      ProfilModel pm = ProfilModel(
        email: profilModel.email,
        kota: profilModel.kota,
        nama: profilModel.nama,
        telepon: profilModel.telepon,
        uid: us.user!.uid,
      );
      if (await Get.find<AppController>().buatAkun(pm)) {
        Get.find<AppController>().profilModel = pm;
        loading.value = false;
        Get.back();
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }
}
