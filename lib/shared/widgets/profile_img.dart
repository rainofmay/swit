import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_circular_indicator.dart';

class ProfileImg extends GetView<UserViewModel> {
  final void Function()? onTap;
  final double? width;
  final double? height;
  final Widget? stackIcon;
  const ProfileImg({super.key, required this.onTap, this.width, this.height, this.stackIcon});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: onTap,
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: controller.profileUrl.isEmpty
              ? Image.asset(
            'assets/images/basic_profile.jpg',
            fit: BoxFit.cover,
            width: width,
            height: height,
          )
              : CachedNetworkImage(
            // CachedNetworkImage 사용
            imageUrl: controller.profileUrl,
            fit: BoxFit.cover,
            width: width,
            height: height,
            placeholder: (context, url) =>
            const CustomCircularIndicator(size: 30.0),
            // 로딩 표시
            errorWidget: (context, url, error) =>
            const CustomCircularIndicator(size: 30.0),
          ),
        ),
        if (stackIcon != null)
        Positioned(
          right: 3,
          bottom: 3,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: ColorBox.dark,
              shape: BoxShape.circle,
            ),
            child: stackIcon,
          ),
        ),
      ]),
    ));
  }
}
