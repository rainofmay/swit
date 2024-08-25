import 'package:flutter/material.dart';

abstract class IconSize {
  /// Extra Small Icon Size
  static const double xs = 14.0;

  /// Small Icon Size
  static const double sm = 16.0;

  /// Medium Icon Size
  static const double md = 18.0;

  /// Large Icon Size
  static const double lg = 20.0;

  /// Extra Large Icon Size
  static const double xl = 22.0;

  /// 커스터마이징
  static const double appBar = 24.0;
  static const double floatingActionButton = 24.0;

  /// Method to get icon size based on device size
  static double getAdaptiveSize(BuildContext context, double baseSize) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    if (deviceWidth > 600) {
      return baseSize * 1.2; // 20% larger on bigger screens
    } else {
      return baseSize;
    }
  }
}