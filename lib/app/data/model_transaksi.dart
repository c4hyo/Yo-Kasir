import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukTransaksiModel {
  String? itemId;
  String? namaProduk;
  int? qtyProduk;
  int? hargaSatuProduk;
  int? hargaProduk;
  bool? isQty;
  ProdukTransaksiModel({
    this.itemId,
    this.namaProduk,
    this.qtyProduk,
    this.hargaSatuProduk,
    this.hargaProduk,
    this.isQty,
  });

  ProdukTransaksiModel.doc(DocumentSnapshot doc) {
    itemId = doc.id;
    namaProduk = doc['nama_produk'];
    qtyProduk = doc['qty_produk'];
    hargaSatuProduk = doc['harga_satu_produk'];
    hargaProduk = doc['harga_produk'];
    isQty = doc['is_qty'];
  }
}

class TransaksiModel {
  String? tokoId;
  String? cabangId;
  String? transaksiId;
  String? createdAt;
  String? dateGroup;
  String? monthGroup;
  int? pembayaran;
  int? totalHarga;
  int? kembalian;
  bool? isLunas;
  String? informasiPembeli;
  TransaksiModel({
    this.tokoId,
    this.cabangId,
    this.transaksiId,
    this.createdAt,
    this.dateGroup,
    this.monthGroup,
    this.pembayaran,
    this.totalHarga,
    this.kembalian,
    this.isLunas,
    this.informasiPembeli,
  });

  TransaksiModel.doc(DocumentSnapshot doc) {
    tokoId = doc['toko_id'];
    cabangId = doc['cabang_id'];
    transaksiId = doc.id;
    createdAt = doc['created_at'];
    dateGroup = doc['date_group'];
    pembayaran = doc['pembayaran'];
    totalHarga = doc['total_harga'];
    kembalian = doc['kembalian'];
    informasiPembeli = doc['informasi_pembeli'];
    isLunas = doc['is_lunas'];
    monthGroup = doc['month_group'];
  }
}
