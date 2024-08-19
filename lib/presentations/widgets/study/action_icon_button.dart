import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionIconButton extends StatelessWidget {
  final dynamic svgAsset;
  final void Function()? onTap;
  const ActionIconButton({super.key, required this.svgAsset, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : onTap,
      child: SvgPicture.asset(
        svgAsset,
        width: 24,
        height: 24,
      ),
    );
  }
}
