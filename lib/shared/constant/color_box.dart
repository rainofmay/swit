import 'package:flutter/material.dart';

abstract class ColorBox {
  /// Transparent Color
  static const Color transparent = Colors.transparent;

  /// White Color
  static Color white = const Color(0xFFFFFFFF);
  static Color transWhite = const Color.fromRGBO(255, 255, 255, 0.8);
  /// Black Color
  static Color black = const Color(0xFF000000);
  static Color dark = const Color(0xff272727);
  /// Primary Color
  static Color primaryColor = const Color(0xFF6A88BE);

  /// BottomBar Color
  static Color secondColor = const Color(0xFFEFEDEA);

  // for background Color
  static Color thirdColor = const Color(0xffE0EAFB);

  // cupertinoswitchColor
  static Color switchColor = const Color(0xff8FB8EE);

  /// Red for Error, Sunday
  static Color darkRed = const Color(0xff790F07);

  /// pink
  static Color customPink = Colors.pink;





  static const int _bluePrimaryValue = 0xFF5356FF;

  static MaterialColor blue = const MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      100: Color(0xFFE1E2FF),
      200: Color(0xFF9092ff),
      300: Color(0xFF7F82FF),
      400: Color(0xFF5A5DFF),
      500: Color(0xFF5356FF),
      600: Color(0xFF4C4FFF),
      700: Color(0xFF4245FF),
      800: Color(0xFF393CFF),
      900: Color(0xFF2A2EFF),
      1000: Color(0xFF1D1EFF),
    },
  );

  /// Grey Color
  static MaterialColor grey = const MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      100: Color(0xFFF8F9FC),
      200: Color(0xFFF0F1F5),
      300: Color(0xFFDBDCE5),
      400: Color(0xFFBDBEC5),
      500: Color(0xFFACADB2),
      600: Color(0xFF96979E),
      700: Color(0xFF808289),
      800: Color(0xFF6B6D75),
      900: Color(0xFF575861),
      1000: Color(0xFF43454C),
    },
  );
  static const int _greyPrimaryValue = 0xFFACADB2;

  /// Green Color
  static MaterialColor green = const MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      100: Color(0xFFF8FFFD),
      200: Color(0xFFDBFFF6),
      300: Color(0xFFBDFFEF),
      400: Color(0xFFA7E7D7),
      500: Color(0xFF90CDBE),
      600: Color(0xFF7AB3A5),
      700: Color(0xFF538075),
      800: Color(0xFF538075),
      900: Color(0xFF40675D),
      1000: Color(0xFF2F4E46),
    },
  );
  static const int _greenPrimaryValue = 0xFF90CDBE;

  /// Pink Color
  static MaterialColor pink = const MaterialColor(
    _pinkPrimaryValue,
    <int, Color>{
      100: Color(0xFFFFF7F7),
      200: Color(0xFFF9D1D1),
      300: Color(0xFFF2ABAB),
      400: Color(0xFFD99595),
      500: Color(0xFFBF7F7F),
      600: Color(0xFFA66B6B),
      700: Color(0xFF8C5858),
      800: Color(0xFF734646),
      900: Color(0xFF593434),
      1000: Color(0xFF402424),
    },
  );
  static const int _pinkPrimaryValue = 0xFFF2ABAB;

  static const MaterialColor red = MaterialColor(
    _redValue,
    <int, Color>{
      900: Color(0xFF7A082D),
      800: Color(0xFF930D2E),
      700: Color(0xFFB7152F),
      600: Color(0xFFDB1F2C),
      500: Color(0xFFFF2E2B),
      400: Color(0xFFFF6F60),
      300: Color(0xFFFF977F),
      200: Color(0xFFFFE3D4),
      100: Color(0xFFFFD5D5),
      50: Color(0xFFFFEFE6),
    },
  );
  static const int _redValue = 0xFFFF2E2B;

  /// Neutral Color
  static MaterialColor neutral = const MaterialColor(
    _neutralValue,
    <int, Color>{
      900: Color(0xFF1C1C4F),
      800: Color(0xFF2E2E5F),
      700: Color(0xFF494976),
      600: Color(0xFF6A6A8D),
      500: Color(0xFF9292A5),
      400: Color(0xFFB7B7C9),
      300: Color(0xFFD4D4E3),
      200: Color(0xFFEAEAF6),
      100: Color(0xFFF5F5FF),
      50: Color(0xFFFAFAFF),
    },
  );
  static const int _neutralValue = 0xFF9292A5;
}
