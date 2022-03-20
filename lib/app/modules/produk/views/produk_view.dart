import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/produk_controller.dart';

class ProdukView extends GetView<ProdukController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProdukView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProdukView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
