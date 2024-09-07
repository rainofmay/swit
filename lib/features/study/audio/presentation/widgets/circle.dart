import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';

class Circle extends StatelessWidget {
  final Widget child;
  final double size;
  final Color backgroundColor;

  const Circle({
    super.key,
    required this.child,
    this.size = 40.0,
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
            blurRadius: 16,
            spreadRadius: 8,
            offset: Offset(-4, -4),
          ),
          // 오른쪽 하단의 어두운 그림자
          BoxShadow(
            color: ColorBox.grey.withOpacity(0.4),
            blurRadius: 16,
            spreadRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}