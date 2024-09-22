import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appbarTitle;
  final bool? isCenterTitle;
  final double? titleSpacing;
  final Widget? leadingWidget;
  final Color? backgroundColor;
  final Color? contentColor;
  final List<Widget>? actions;

  const CustomAppBar({super.key,
    this.appbarTitle,
    this.isCenterTitle,
    this.titleSpacing,
    this.leadingWidget,
    this.backgroundColor,
    this.contentColor,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      titleSpacing: titleSpacing,
      centerTitle: isCenterTitle ?? false,
      backgroundColor: backgroundColor ?? ColorBox.white,
      shape: Border(
        bottom: BorderSide(
          color: backgroundColor ?? ColorBox.white,
        ),
      ),
      leading: leadingWidget,
      title: Text(
        appbarTitle ?? '',
        style: FontBox.H4.copyWith(color: contentColor ?? ColorBox.black, letterSpacing: 1),
      ),
      // centerTitle: true,
      actions: actions,
    );
  }
}
