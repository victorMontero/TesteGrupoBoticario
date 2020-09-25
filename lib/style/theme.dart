import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MyColors {

  const MyColors();

  static const Color mainColor = const Color(0xFFEF7F2D);
  static const Color secondColor = const Color(0xFFEB592C);
  static const Color grey = const Color(0xFFE5E5E5);
  static const Color background = const Color(0xFFf0f1f6);
  static const Color titleColor = const Color(0xFF416E98);
  static const Color greenColor = const Color(0xFF8BBD3A);
  static const Color greenLight = const Color(0xFFD3DB30);
  static const primaryGradient = const LinearGradient(
    colors: const [ Color(0xFFEF7F2D), Color(0xFFEB592C)],
    stops: const [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}