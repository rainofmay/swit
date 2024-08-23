import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Widget? contents;
  final Widget actionWidget;

  const CustomAlertDialog(
      {super.key,
      required this.title,
      required this.width,
      required this.height,
      this.contents,
      required this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorBox.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      title:
          Text(title, style: FontBox.MIDDLETITLE, textAlign: TextAlign.center),
      content: SizedBox(width: width, height: height, child: contents),
      actions: [
        actionWidget,
      ],
      actionsPadding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
      contentPadding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
    );
  }
}
