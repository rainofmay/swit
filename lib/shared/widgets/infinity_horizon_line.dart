import 'package:flutter/material.dart';


class InfinityHorizonLine extends StatelessWidget {
  const InfinityHorizonLine({
    super.key,
    required this.gap,
    this.color,
  });

  final Color? color;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: gap,
      color: color,
    );
  }
}
