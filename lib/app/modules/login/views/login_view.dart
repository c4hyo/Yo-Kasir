import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/modules/login/bindings/login_binding.dart';
import 'package:yo_kasir/app/modules/login/views/registrasi_view.dart';
import 'package:yo_kasir/config/theme.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: SvgPicture.asset("assets/people.svg"),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.025,
                      ),
                      Text(
                        "Hallo, ",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 32.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Login Sekarang",
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
                          controller.login(
                            email: email.text,
                            password: password.text,
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Jika belum punya akun, "),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => RegistrasiView(),
                                binding: LoginBinding(),
                              );
                            },
                            child: Text(
                              "Buat disini",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
