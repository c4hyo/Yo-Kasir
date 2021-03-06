import 'package:get/get.dart';

import 'package:yo_kasir/app/modules/cabang/bindings/cabang_binding.dart';
import 'package:yo_kasir/app/modules/cabang/views/cabang_view.dart';
import 'package:yo_kasir/app/modules/detailTransaksi/bindings/detail_transaksi_binding.dart';
import 'package:yo_kasir/app/modules/detailTransaksi/views/detail_transaksi_view.dart';
import 'package:yo_kasir/app/modules/home/bindings/home_binding.dart';
import 'package:yo_kasir/app/modules/home/views/home_view.dart';
import 'package:yo_kasir/app/modules/item/bindings/item_binding.dart';
import 'package:yo_kasir/app/modules/item/views/item_view.dart';
import 'package:yo_kasir/app/modules/login/bindings/login_binding.dart';
import 'package:yo_kasir/app/modules/login/views/login_view.dart';
import 'package:yo_kasir/app/modules/produk/bindings/produk_binding.dart';
import 'package:yo_kasir/app/modules/produk/views/produk_view.dart';
import 'package:yo_kasir/app/modules/toko/bindings/toko_binding.dart';
import 'package:yo_kasir/app/modules/toko/views/toko_view.dart';
import 'package:yo_kasir/app/modules/transaksi/bindings/transaksi_binding.dart';
import 'package:yo_kasir/app/modules/transaksi/views/transaksi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TOKO,
      page: () => TokoView(),
      binding: TokoBinding(),
    ),
    GetPage(
      name: _Paths.CABANG,
      page: () => CabangView(),
      binding: CabangBinding(),
    ),
    GetPage(
      name: _Paths.ITEM,
      page: () => ItemView(),
      binding: ItemBinding(),
    ),
    GetPage(
      name: _Paths.PRODUK,
      page: () => ProdukView(),
      binding: ProdukBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI,
      page: () => TransaksiView(),
      binding: TransaksiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_TRANSAKSI,
      page: () => DetailTransaksiView(),
      binding: DetailTransaksiBinding(),
    ),
  ];
}
