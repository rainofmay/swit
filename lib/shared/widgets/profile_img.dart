import 'package:flutter/material.dart';

class ProfileImg extends StatelessWidget {
  final Widget? widget;
  final double? width;
  final double? height;
  const ProfileImg({super.key, this.widget, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: widget ??
          Image.asset(
        'assets/images/basic_profile.jpg',
        fit: BoxFit.cover,
        width: width ?? 40,
        height: height ?? 40,
      )
    );
  }
}
