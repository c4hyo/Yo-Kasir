import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UpdateCabangView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateCabangView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UpdateCabangView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
