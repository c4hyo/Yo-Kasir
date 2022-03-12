import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TambahItemView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TambahItemView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TambahItemView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
