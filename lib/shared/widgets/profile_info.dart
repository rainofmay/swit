import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class ProfileInfo extends GetView<UserViewModel> {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUsername(),
              _buildIntroduction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsername() {
    final username = controller.username.trim();
    return Text(
      username.isEmpty ? '이름을 설정해 주세요.' : username,
      style: FontBox.B1.copyWith(
        color: username.isEmpty ? ColorBox.grey : null,
      ),
    );
  }

  Widget _buildIntroduction() {
    final introduction = controller.introduction.trim();
    if (introduction.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGap(6),
        Text(
          introduction,
          style: FontBox.B3.copyWith(color: ColorBox.grey),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
