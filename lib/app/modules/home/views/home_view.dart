import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';

import 'package:get/get.dart';
import 'package:yo_kasir/app/controllers/app_controller.dart';
import 'package:yo_kasir/app/data/model_cabang.dart';
import 'package:yo_kasir/app/data/model_toko.dart';
import 'package:yo_kasir/app/modules/toko/bindings/toko_binding.dart';
import 'package:yo_kasir/app/modules/toko/views/tambah_toko_view.dart';
import 'package:yo_kasir/app/routes/app_pages.dart';
import 'package:yo_kasir/config/collection.dart';
import 'package:yo_kasir/config/theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final appC = Get.find<AppController>();
  final kode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appC = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              auth.signOut();
              Get.find<AppController>().resetProfil();
            },
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
              appC.profilModel.nama!.capitalize!,
              style: TextStyle(
                color: darkText,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
                      Get.to(
                        () => TambahTokoView(),
                        binding: TokoBinding(),
                        arguments: {"toko": TokoModel()},
                      );
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
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: darkText,
                                  style: TextStyle(
                                    color: darkText,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Masukan Kode Toko",
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
                                ElevatedButton(
                                  onPressed: () {
                                    controller.gabungToko(
                                      kode.text,
                                      appC.profilModel.uid,
                                    );
                                  },
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
            Obx(
              () => StreamBuilder<QuerySnapshot>(
                stream: tokoDb
                    .where("akses", arrayContains: appC.profilModel.uid)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, i) {
                      DocumentSnapshot doc = snapshot.data!.docs[i];
                      TokoModel toko = TokoModel.doc(doc);

                      return _cardToko(toko);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardToko(TokoModel toko) {
    return Card(
      color: primaryColorAccent,
      child: Container(
        padding: paddingList,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              toko.namaToko!.capitalize!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(toko.alamatToko!.capitalizeFirst! +
                " ~ (" +
                toko.telepon! +
                ")"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (toko.pemilikId == appC.profilModel.uid) {
                  Get.toNamed(Routes.TOKO, arguments: {"toko": toko});
                } else {
                  Get.toNamed(Routes.CABANG, arguments: {
                    "toko": toko,
                    "cabang": CabangModel(),
                  });
                }
              },
              child: Text("Masuk Toko"),
            ),
          ],
        ),
      ),
    );
  }
}
