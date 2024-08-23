import 'package:flutter/material.dart';

class CustomGap extends StatelessWidget {
  final double size;

  const CustomGap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    final isInColumn = context.findAncestorWidgetOfExactType<Column>() != null;
    final isInRow = context.findAncestorWidgetOfExactType<Row>() != null;

    double height = isInColumn ? size : 0;
    double width = isInRow ? size : 0;

    return SizedBox(
      height: height,
      width: width,
    );
  }
}
