import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';

class AuthButton extends StatelessWidget {
  final double width;
  final double height;
  final void Function()? onPressed;
  const AuthButton({super.key, required this.width, required this.height, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          overlayColor: ColorBox.transparent,
          foregroundColor: ColorBox.transparent,
          fixedSize: Size(width, height),
          backgroundColor: ColorBox.white),
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(
            'assets/images/apple.png',
            width: 48,
            height: 48,
          ),
          Expanded(
            child: Center(
              child: Text(
                'Apple로 로그인',
                style: FontBox.TITLESTYLE,
              ),
            ),
          ),
        ],
      ),
    );
  }
}