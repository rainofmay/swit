import 'package:flutter/material.dart';
import 'package:swit/constant/color_box.dart';
import 'package:swit/constant/font_box.dart';

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
      centerTitle: isCenterTitle,
      backgroundColor: backgroundColor,
      shape: Border(
        bottom: BorderSide(
          color: backgroundColor ?? ColorBox.white,
        ),
      ),
      leading: leadingWidget,
      title: Text(
        appbarTitle ?? '',
        style: FontBox.TITLESTYLE.copyWith(color: contentColor ?? ColorBox.black),
      ),
      // centerTitle: true,
      actions: actions,
    );
  }
}
