import 'package:cloud_firestore/cloud_firestore.dart';

class TokoModel {
  String? tokoId;
  String? namaToko;
  String? alamatToko;
  String? pemilikId;
  int? cabang;
  List<dynamic>? akses;
  String? kodeToko;
  String? telepon;
  TokoModel({
    this.tokoId,
    this.namaToko,
    this.alamatToko,
    this.pemilikId,
    this.cabang,
    this.akses,
    this.kodeToko,
    this.telepon,
  });

  TokoModel.doc(DocumentSnapshot doc) {
    tokoId = doc.id;
    namaToko = doc['nama_toko'];
    alamatToko = doc['alamat_toko'];
    pemilikId = doc['pemilik_id'];
    cabang = doc['cabang'];
    akses = doc['akses'];
    kodeToko = doc['kode_toko'];
    telepon = doc['telepon'];
  }
}
