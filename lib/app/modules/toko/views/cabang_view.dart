import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CabangView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cabang View'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Nama Cabang"),
            subtitle: Text("Alamat"),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text("Masuk"),
            ),
          ),
        ],
      ),
    );
  }
}
