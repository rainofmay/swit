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
  final PreferredSizeWidget? bottom;

  const CustomBackAppBar(
      {super.key,
      required this.appbarTitle,
      this.backFunction,
        required this.isLeading,
        required this.isCenterTitle,
      this.backgroundColor,
      this.contentColor,
      this.actions, this.bottom,
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
          size: 22,
          color: contentColor,
        ),
      ) : Container(),
      title: Text(
        appbarTitle,
        style: FontBox.H4.copyWith(color: contentColor ?? ColorBox.black, letterSpacing: 1),
      ),
      // centerTitle: true,
      actions: actions,
      bottom: bottom,
    );
  }
}
