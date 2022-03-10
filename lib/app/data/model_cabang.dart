import 'package:cloud_firestore/cloud_firestore.dart';

class CabangModel {
  String? cabangId;
  String? namaCabang;
  String? alamatCabang;
  List<dynamic>? pengelola;
  String? kodeCabang;
  String? telepon;
  CabangModel({
    this.cabangId,
    this.namaCabang,
    this.alamatCabang,
    this.pengelola,
    this.kodeCabang,
    this.telepon,
  });

  CabangModel.doc(DocumentSnapshot doc) {
    cabangId = doc.id;
    namaCabang = doc['nama_cabang'];
    alamatCabang = doc['alamat_cabang'];
    pengelola = doc['pengelola'];
    kodeCabang = doc['kode_cabang'];
    telepon = doc['telepon'];
  }
}
