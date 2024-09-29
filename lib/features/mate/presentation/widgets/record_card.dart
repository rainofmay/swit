import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: ColorBox.secondColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('일지 카드 (테스트)'),
    );
  }
}
