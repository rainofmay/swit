import 'package:flutter/material.dart';
import 'package:swit/constant/color_box.dart';

ThemeData theme = ThemeData(
    dividerColor: ColorBox.transparent,
    fontFamily: 'cafe24OhsquareAir',
    splashColor: ColorBox.transparent,
    //클릭했을 때 애니매이션 없애는 코드
    highlightColor: ColorBox.transparent,
    //클릭했을 때 애니매이션 없애는 코드
    hoverColor: ColorBox.transparent,
    focusColor: ColorBox.transparent,
    textTheme: const TextTheme(
        labelSmall: TextStyle(
          color: Colors.black,
          fontSize: 9,
          fontWeight: FontWeight.w100,
          height: 2.2,
          letterSpacing: 1.5,
        )),
    scaffoldBackgroundColor: ColorBox.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorBox.black,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorBox.primaryColor,
      unselectedItemColor: ColorBox.grey.shade800,
      selectedLabelStyle: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w100,
          height: 2.2,
          letterSpacing: 1.5,
          fontFamily: 'cafe24OhsquareAir'),
      unselectedLabelStyle: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.normal,
          height: 2.2,
          letterSpacing: 1.5,
          fontFamily: 'cafe24OhsquareAir'),
      selectedIconTheme: const IconThemeData(size: 20),
      unselectedIconTheme: const IconThemeData(size: 20),
    ),

    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: ColorBox.primaryColor, // 텍스트 선택 핸들 색상
      cursorColor: ColorBox.primaryColor, // 커서 색상
      selectionColor: ColorBox.primaryColor.withOpacity(0.5), // 선택된 텍스트 배경색

    ),

    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      overlayColor: WidgetStateColor.transparent,
      indicatorColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: ColorBox.transparent,
    ),
    iconButtonTheme: IconButtonThemeData(
        style : IconButton.styleFrom(
          highlightColor: ColorBox.transparent,
          hoverColor: ColorBox.transparent,
          focusColor: ColorBox.transparent,
        )
    ),
  sliderTheme: SliderThemeData(
    trackHeight: 2,
    trackShape: const RoundedRectSliderTrackShape(),
    thumbColor: ColorBox.white,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 13),
    overlayColor: ColorBox.primaryColor.withOpacity(0.2),
    activeTrackColor: ColorBox.primaryColor,
    inactiveTrackColor: ColorBox.grey[700],
  ),
);
