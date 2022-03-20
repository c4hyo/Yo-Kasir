import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? itemId;
  int? qty;
  int? harga;
  String? namaItem;
  String? deskripsi;
  String? kategoriId;
  bool? isDiskon;
  bool? useQty;
  bool? dijual;
  int? diskon;
  int? hargaDiskon;
  ItemModel({
    this.itemId,
    this.qty,
    this.harga,
    this.namaItem,
    this.deskripsi,
    this.kategoriId,
    this.isDiskon,
    this.useQty,
    this.diskon,
    this.dijual,
    this.hargaDiskon,
  });
  ItemModel.doc(DocumentSnapshot doc) {
    itemId = doc.id;
    qty = doc['qty'];
    harga = doc['harga'];
    namaItem = doc['nama'];
    deskripsi = doc['deskripsi'];
    kategoriId = doc['kategori_id'];
    diskon = doc['diskon'];
    hargaDiskon = doc['harga_diskon'];
    isDiskon = doc['is_diskon'];
    useQty = doc['use_qty'];
    dijual = doc['dijual'];
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
