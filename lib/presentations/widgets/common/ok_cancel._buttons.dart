import 'package:flutter/material.dart';
import 'package:swit/constant/font_box.dart';

class OkCancelButtons extends StatelessWidget {
  final String okText;
  final Color? okTextColor;
  final String? cancelText;
  final Color? cancelTextColor;
  final VoidCallback? onCancelPressed;
  final VoidCallback onPressed;

  const OkCancelButtons(
      {super.key,
      required this.okText,
      this.okTextColor = Colors.black,
      this.cancelText,
      this.cancelTextColor = Colors.black,
      required this.onPressed,
      this.onCancelPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // height: 30,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: Text(cancelText ?? '',
                style: cancelTextColor != null
                    ? FontBox.DIALOGSTYLE.copyWith(color: cancelTextColor)
                    : FontBox.DIALOGSTYLE),
            onPressed: () {
              Navigator.of(context).pop(); // 닫히는 버튼
              onCancelPressed;
            },
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(okText,
                style: okTextColor != null
                    ? FontBox.DIALOGSTYLE.copyWith(color: okTextColor)
                    : FontBox.DIALOGSTYLE),
          ),
        ],
      ),
    );
  }
}
