import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';

class CustomBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;
  final GestureTapCallback? backFunction;
  final bool isLeading;
  final bool isCenterTitle;
  final Color? backgroundColor;
  final Color? contentColor;
  final List<Widget>? actions;

  const CustomBackAppBar(
      {super.key,
      required this.appbarTitle,
      this.backFunction,
        required this.isLeading,
        required this.isCenterTitle,
      this.backgroundColor,
      this.contentColor,
      this.actions,
      });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: -5,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? ColorBox.white,
      centerTitle: isCenterTitle,
      shape: Border(
        bottom: BorderSide(
          color: backgroundColor ?? ColorBox.white,
        ),
      ),
      leading: isLeading ? IconButton(
        hoverColor: ColorBox.transparent,
        splashColor: ColorBox.transparent,
        highlightColor: ColorBox.transparent,
        onPressed: backFunction ?? () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back,
          size: 24,
          color: contentColor,
        ),
      ) : Container(),
      title: Text(
        appbarTitle,
        style: FontBox.TITLESTYLE.copyWith(color: contentColor ?? ColorBox.black),
      ),
      // centerTitle: true,
      actions: actions,
    );
  }
}
