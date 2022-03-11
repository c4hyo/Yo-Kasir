import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/routes/app_pages.dart';
import 'package:yo_kasir/config/theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final kode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: paddingList,
        child: ListView(
          children: [
            Text(
              "Selamat Datang",
              style: TextStyle(
                color: darkText,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Nama Pengguna",
              style: TextStyle(
                color: darkText,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: controller.count.value + 1,
                itemBuilder: (_, i) {
                  if (i == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Toko Anda"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.increment();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(width: 5),
                                    Text("Tambah Toko"),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: secondaryColor,
                                ),
                                onPressed: () {
                                  Get.dialog(
                                    Dialog(
                                      child: Container(
                                        padding: paddingList,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Gabung Toko"),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: kode,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              cursorColor: darkText,
                                              style: TextStyle(
                                                color: darkText,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: "Masukan Kode Toko",
                                                contentPadding:
                                                    EdgeInsets.all(20),
                                                filled: true,
                                                fillColor: primaryColorAccent,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                    color: primaryColorAccent,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                    color: primaryColorAccent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                "Gabung",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      LineariconsFree.enter,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Gabung Toko",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return _cardToko();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardToko() {
    return Card(
      child: Container(
        padding: paddingList,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama Toko"),
            SizedBox(
              height: 10,
            ),
            Text("Alamat"),
            SizedBox(
              height: 10,
            ),
            Text("Pengelola"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.size.width * 0.1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (_, x) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        child: CircleAvatar(
                          backgroundColor: primaryColorAccent,
                          radius: 20,
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.TOKO);
                  },
                  child: Text("Masuk Toko"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
