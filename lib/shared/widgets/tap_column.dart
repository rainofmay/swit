import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class TapColumn extends StatelessWidget {
  final void Function() onTap;
  final Widget? widget;
  final String? text;
  final Color? color;
  const TapColumn({super.key, this.widget, this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget ?? const SizedBox(),
          const CustomGap(8),
          Text(text ?? '', style: TextStyle(fontSize: 12, color: color ?? ColorBox.black)),
        ],
      ),
    );
  }
}
