import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final double radius;
  final void Function(bool?)? onChanged;
  final Color? checkColor;
  final Color? activeColor;
  final Color? borderColor;
  const CustomCheckBox({super.key, required this.value, this.onChanged, this.checkColor, this.activeColor, this.borderColor, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        splashRadius: 0,
        activeColor: activeColor ?? ColorBox.white,
        checkColor: checkColor ?? ColorBox.primaryColor,
        hoverColor: ColorBox.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor ?? ColorBox.black),
        ),
        value: value,
        onChanged: onChanged);
  }
}
