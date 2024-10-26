import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/user/profile_cache_manager.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/optimized_profile_image.dart';

class MyProfileImg extends GetView<UserViewModel> {
  final void Function()? onTap;
  final double width;
  final double height;
  final Widget? stackIcon;

  const MyProfileImg(
      {super.key,
      required this.onTap,
      required this.width,
      required this.height,
      this.stackIcon});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final imageUrl = controller.profileUrl;

      return Stack(children: [
        OptimizedProfileImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          onTap: onTap,
        ),
        if (stackIcon != null)
          Positioned(
            right: 3,
            bottom: 3,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: ColorBox.grey,
                shape: BoxShape.circle,
              ),
              child: stackIcon,
            ),
          ),
      ]);
    });
  }
}
