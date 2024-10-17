import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/infinity_vertical_line.dart';

class FollowInfo extends GetView<UserViewModel> {
  const FollowInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildColumn('팔로워', '${controller.followerCount}'),
        const CustomGap(20),
        Container(
          height: 30,
          width: 1,
          color: ColorBox.grey.withOpacity(0.5),
        ),
        const CustomGap(20),
        _buildColumn('팔로잉', '${controller.followingCount}'),
      ],
    ));
  }

  Widget _buildColumn(String label, String count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: FontBox.B3.copyWith(color: ColorBox.grey)),
        const SizedBox(height: 4),
        Text(count, style: FontBox.B2.copyWith(color: ColorBox.dark)),
      ],
    );
  }
}
