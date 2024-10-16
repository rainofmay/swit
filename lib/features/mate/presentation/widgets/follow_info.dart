import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/infinity_vertical_line.dart';

class FollowInfo extends GetView<MateViewModel> {
  const FollowInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildColumn('팔로워', '${controller.followerList.length}'),
        const CustomGap(20),
        Container(
          height: 30, // 구분선의 높이
          width: 1, // 구분선의 두께
          color: ColorBox.grey.withOpacity(0.5), // 구분선의 색상
        ),
        const CustomGap(20),
        Obx(() => _buildColumn('팔로잉', '${controller.followingList.length}')),
      ],
    );
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
