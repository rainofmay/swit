import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';

class Circle extends StatelessWidget {
  final Widget child;
  final double size;
  final Color backgroundColor;

  const Circle({
    super.key,
    required this.child,
    this.size = 38.0,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: ColorBox.white,
            blurRadius: 6,
            spreadRadius: 3,
            offset: Offset(-2, -2),
          ),
          // 오른쪽 하단의 어두운 그림자
          BoxShadow(
            color: ColorBox.grey.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: 3,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}