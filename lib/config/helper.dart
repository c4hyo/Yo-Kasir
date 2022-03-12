import 'dart:math';

import 'package:intl/intl.dart';

class Helper {
  static searchCase(String judul) {
    List<String> caseSearch = [];
    String temp = "";
    for (var i = 0; i < judul.length; i++) {
      if (judul[i] == " ") {
        temp = "";
      } else {
        temp = temp + judul[i];
        caseSearch.add(temp);
      }
    }
    return caseSearch;
  }

  static generateCode() {
    // digunakan untuk mengenerate string,
    //contoh penggunaan pada generate code
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(8, (_) {
      return _chars.codeUnitAt(_rnd.nextInt(_chars.length));
    }));
  }

  static date(String? date) {
    // digunakan untuk memformat tanggal
    return DateFormat.yMMMMd("id").add_jms().format(DateTime.parse(date!));
  }

  static tanggal(String? date) {
    return DateFormat.MMMMd("id").format(DateTime.parse(date!));
  }

  static final rupiah = NumberFormat.simpleCurrency(locale: "id_ID");
}
