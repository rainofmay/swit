

import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';

Future<void> customDialog(BuildContext context, double height, String title,
    Widget contents, Widget? actionWidget) async {
  await showDialog<void>(
    context: context,
    builder: (context) {
      // 빌더로 AlertDialog 위젯을 생성
      return AlertDialog(
        backgroundColor: ColorBox.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        title: Text(title, style: FontBox.DIALOGSTYLE),
        content: SizedBox(
            height: height,
            child: contents),
        actions: actionWidget == null
            ? null
            : [
          actionWidget,
        ],
        actionsPadding: const EdgeInsets.only(top: 0, bottom: 5, left: 0, right: 20),
      );
    },
  );
}