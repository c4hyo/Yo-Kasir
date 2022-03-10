import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilModel {
  String? uid;
  String? nama;
  String? email;
  String? kota;
  List<dynamic>? telepon;
  ProfilModel({
    this.uid,
    this.nama,
    this.email,
    this.kota,
    this.telepon,
  });

  ProfilModel.doc(DocumentSnapshot doc) {
    uid = doc.id;
    nama = doc['nama'];
    email = doc['email'];
    kota = doc['kota'];
    telepon = doc['telepon'];
  }
}
