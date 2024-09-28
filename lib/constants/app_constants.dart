import 'package:flutter/material.dart';

class AppConstants {
  // colors
  static Color authBgColor = const Color(0xff4C6A7C).withOpacity(.8);
  static const Color mainRed = Color(0xff984A40);
  static const Color mainWhite = Color(0xffE6E4DF);
  
  // regex
  static RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}