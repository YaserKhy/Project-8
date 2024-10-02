import 'package:flutter/material.dart';

class AppConstants {
  // colors
  static Color authBgColor = const Color(0xff4C6A7C).withOpacity(.8);

  static const Color mainBgColor = Color(0xffEEEDEA);
  static const Color mainRed = Color(0xff984A40);
  static const Color mainWhite = Color(0xffE6E4DF);
  static const Color mainBlue = Color(0xff4C6A7C);
  static const Color mainlightBlue = Color(0xff93B0C4);

  static const Color green = Color(0xff34A853);
  static const Color textColor = Color(0xff313131);
  static const Color subTextColor = Color(0xff525252);

  static const Color unselectedColor = Color(0xffA8A8A8);

  // regex
  static RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}
