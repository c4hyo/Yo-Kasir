import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_toko.dart';

class TokoController extends GetxController {
  final tokoM = TokoModel().obs;

  @override
  void onInit() {
    super.onInit();
    tokoM.value = tokoM(Get.arguments["toko"] ?? TokoModel());
  }

  @override
  void onClose() {
    tokoM.value = tokoM(TokoModel());
  }
}
