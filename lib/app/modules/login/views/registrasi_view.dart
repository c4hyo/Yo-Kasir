import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/data/model_profil.dart';
import 'package:yo_kasir/app/modules/login/controllers/login_controller.dart';
import 'package:yo_kasir/config/theme.dart';

class RegistrasiView extends GetView<LoginController> {
  final nama = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => controller.loading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Padding(
                  padding: paddingList,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: Get.size.height * 0.025,
                      ),
                      Container(
                        width: Get.size.width * 0.5,
                        height: Get.size.width * 0.5,
                        child: SvgPicture.asset("assets/registrasi.svg"),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.025,
                      ),
                      Text(
                        "Registrasi Sekarang",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.025,
                      ),
                      TextFormField(
                        controller: nama,
                        cursorColor: darkText,
                        style: TextStyle(
                          color: darkText,
                        ),
                        decoration: InputDecoration(
                          hintText: "Nama",
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: primaryColorAccent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColorAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColorAccent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.025,
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: darkText,
                        style: TextStyle(
                          color: darkText,
                        ),
                        decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: primaryColorAccent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColorAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColorAccent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.025,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        cursorColor: darkText,
                        style: TextStyle(
                          color: darkText,
                        ),
                        decoration: InputDecoration(
                          hintText: "Kata Sandi",
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: primaryColorAccent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColorAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColorAccent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.025,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(Get.size.width, 55),
                        ),
                        onPressed: () {
                          ProfilModel pm = ProfilModel(
                            email: email.text,
                            kota: "",
                            nama: nama.text,
                            telepon: [],
                          );
                          controller.registrasi(pm, password.text);
                        },
                        child: Text(
                          "Buat Akun",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
