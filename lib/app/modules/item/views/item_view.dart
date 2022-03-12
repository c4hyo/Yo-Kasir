import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/item_controller.dart';

class ItemView extends GetView<ItemController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ItemView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ItemView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
