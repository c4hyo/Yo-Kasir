import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/theme.dart';

/// Saran penggunaan, Row > Expanded[flex] > cardCount
///
/// parameter cardCount:
/// * total [int],
///
/// * judul [String],
///
/// * warna [Color],
///
/// * icon [IconData],
///
/// * onTap [Function]

Widget cardCount({
  int? total,
  String? judul,
  Color? warnaBackground,
  Color? warnaAngka,
  IconData? icon,
  Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      color: warnaBackground,
      elevation: 2,
      child: Container(
        padding: paddingList,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 35,
              color: warnaAngka,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              total.toString(),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: warnaAngka,
              ),
            ),
            Text(judul.toString().capitalize!),
          ],
        ),
      ),
    ),
  );
}
