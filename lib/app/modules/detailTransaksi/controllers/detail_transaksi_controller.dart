import 'package:get/get.dart';

class DetailTransaksiController extends GetxController {
  final transaksiId = "".obs;
  final bayar = 0.obs;
  final count = 0.obs;

  @override
  void onInit() {
    transaksiId.value = Get.arguments['transaksi'];
    super.onInit();
  }

  @override
  void onClose() {
    transaksiId.value = "";
  }
}
