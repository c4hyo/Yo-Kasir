import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? itemId;
  int? qty;
  int? harga;
  String? namaItem;
  String? deskripsi;
  String? kategoriId;
  ItemModel({
    this.itemId,
    this.qty,
    this.harga,
    this.namaItem,
    this.deskripsi,
    this.kategoriId,
  });
  ItemModel.doc(DocumentSnapshot doc) {
    itemId = doc.id;
    qty = doc['qty'];
    harga = doc['harga'];
    namaItem = doc['nama'];
    deskripsi = doc['deskripsi'];
    kategoriId = doc['kategori_id'];
  }
}

class KategoriModel {
  String? kategoriId;
  String? namaKategori;
  KategoriModel({
    this.kategoriId,
    this.namaKategori,
  });
}
