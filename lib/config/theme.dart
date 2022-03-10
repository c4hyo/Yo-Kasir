import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final primaryColor = Color.fromARGB(255, 76, 203, 235);
final primaryColorAccent = Color(0xffd7eef4);

Color lightText = Color.fromARGB(221, 221, 220, 220);
Color darkText = Colors.black87;
Color lightBackground = Color.fromARGB(255, 246, 252, 252);

ThemeData tema = ThemeData(
  textTheme: GoogleFonts.montserratTextTheme(),
  scaffoldBackgroundColor: lightBackground,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    splashColor: primaryColorAccent,
    elevation: 0,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: primaryColorAccent,
    titleTextStyle: GoogleFonts.kaushanScript(
      color: darkText,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    centerTitle: true,
    actionsIconTheme: IconThemeData(
      color: darkText,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);

ButtonStyle borderButton = ButtonStyle(
  side: MaterialStateProperty.all(
    BorderSide(color: primaryColor),
  ),
  backgroundColor: MaterialStateProperty.all(lightBackground),
  textStyle: MaterialStateProperty.all(TextStyle(
    color: primaryColor,
  )),
);
