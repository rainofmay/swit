import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class TapRow extends StatelessWidget {
  final Widget? widget;
  final String title;
  final double? fontSize;
  final void Function()? onTap;
  final Widget? action;

  const TapRow({
    super.key,
    this.widget,
    this.fontSize,
    required this.title,
    this.onTap,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  widget ?? const SizedBox(),
                  const CustomGap(12),
                  Text(title,
                      style: FontBox.MIDDLETITLE),
                ],
              ),
            ),
            if (action != null) action!,
          ],
        ));
  }
}
