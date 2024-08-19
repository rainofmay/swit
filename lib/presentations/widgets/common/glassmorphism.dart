import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swit/constant/color_box.dart';

class GlassMorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final Widget child;

  const GlassMorphism(
      {super.key,
        required this.blur,
        required this.opacity,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: ColorBox.white.withOpacity(opacity),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: child,
        ),
      ),
    );
  }
}
