import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/modules/home/views/home_view.dart';
import 'package:yo_kasir/app/modules/login/views/login_view.dart';

import 'app/routes/app_pages.dart';
import 'config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      title: "Application",
      debugShowCheckedModeBanner: false,
      home: WrapAuth(),
      getPages: AppPages.routes,
      theme: tema,
    );
  }
}

class WrapAuth extends StatelessWidget {
  const WrapAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(
      init: AppController(),
      builder: (_) {
        if (Get.find<AppController>().user?.uid != null) {
          if (Get.find<AppController>().profilModel.uid == null) {
            Get.find<AppController>()
                .getProfilPengguna(Get.find<AppController>().user!.uid);
          } else {
            return HomeView();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return LoginView();
        }
      },
    );
  }
}
