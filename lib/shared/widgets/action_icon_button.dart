import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionIconButton extends StatelessWidget {
  final dynamic svgAsset;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final ColorFilter? colorFilter;
  const ActionIconButton({super.key, required this.svgAsset, this.onTap, this.width, this.height, this.colorFilter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : onTap,
      child: SvgPicture.asset(
        colorFilter: colorFilter,
        svgAsset,
        width: width ?? 20,
        height: height ?? 20,
      ),
    );
  }
}
