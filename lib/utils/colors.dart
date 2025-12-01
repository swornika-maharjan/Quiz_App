import 'dart:ui';

import 'package:flutter/material.dart';

class QZColor {
  static const Color white = Color(0xffffffff);
  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color purple = Colors.purple;
  static const Color buttonColor = Color(0xff6750A4);

  static const Color color1 = Color(0xFFDCC5F8); // #DCC5F8
  static const Color color2 = Color(0xFF7300FF); // #7300FF

  static const LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      color2,
      color1,
    ],
  );
}
