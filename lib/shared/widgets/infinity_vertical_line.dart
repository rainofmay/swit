import 'package:flutter/material.dart';


class InfinityVerticalLine extends StatelessWidget {
  const InfinityVerticalLine({
    super.key,
    required this.gap,
    this.color,
  });

  final Color? color;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: gap,
      height: double.infinity,
      color: color,
    );
  }
}
