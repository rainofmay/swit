// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:swit/app/config/app_config.dart';
import 'package:swit/shared/constant/color_box.dart';

abstract class FontBox {
  /* -------------------------------------------------- */
  /* STANDARD FONTS ----------------------------------- */
  /* -------------------------------------------------- */
  static const TextStyle H1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: Colors.black,
  );

  static const TextStyle H2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: Colors.black,
  );

  static const TextStyle H3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: Colors.black,
  );

  // Appbar title
  static const TextStyle H4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: Colors.black,
  );

  //Contents style
  static const TextStyle H5 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: Colors.black,
  );

  // Contents - Lists, Appbar actions title
  static const TextStyle B1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: Colors.black,
  );

  static const TextStyle B2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: Colors.black,
  );

  static const TextStyle B3 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: Colors.black,
  );
  
  /* -------------------------------------------------- */
  /* CUSTOMIZED FONTS --------------------------------- */
  /* -------------------------------------------------- */

  // Appbar actions style
  static TextStyle activtedActions = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: ColorBox.primaryColor,
  );

  static TextStyle disabledActions = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: AppConfig.APP_FONT_STYLE,
    color: ColorBox.grey,
  );
}
