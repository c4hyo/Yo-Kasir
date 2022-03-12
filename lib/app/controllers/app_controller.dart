import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_profil.dart';
import 'package:yo_kasir/config/collection.dart';

class AppController extends GetxController {
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;

  final _profil = ProfilModel().obs;
  ProfilModel get profilModel => _profil.value;
  set profilModel(ProfilModel pm) => _profil.value = pm;

  // buat akun dan disimpan di database firebase
  Future<bool> buatAkun(ProfilModel profilModel) async {
    try {
      await profilDb.doc(profilModel.uid).set({
        "uid": profilModel.uid,
        "nama": profilModel.nama,
        "email": profilModel.email,
        "kota": profilModel.kota,
        "telepon": profilModel.telepon,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // berfungsi untuk mengambil data dari database, pada saat baru login
  Future<ProfilModel> profilPengguna(String uid) async {
    try {
      DocumentSnapshot doc = await profilDb.doc(uid).get();
      return ProfilModel.doc(doc);
    } catch (e) {
      rethrow;
    }
  }

  // berfungsi untuk mengambil data dari database pada saat sudah login,
  //
  // fungsi ini digunakan pada saat data profil menjadi null
  getProfilPengguna(String uid) {
    return profilPengguna(uid).then((value) => profilModel = value);
  }

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(auth.authStateChanges());
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
  }
}
