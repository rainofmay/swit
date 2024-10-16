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
              if (controller.username.trim().isEmpty)
                Text('이름을 설정해 주세요.',
                    style: FontBox.B1.copyWith(color: ColorBox.grey))
              else
                Text(controller.username.trim(), style: FontBox.B1),
              const CustomGap(6),
              if (controller.introduction.trim().isEmpty)
                const SizedBox()
              else
                Text(
                  controller.introduction.trim(),
                  style: FontBox.B3.copyWith(color: ColorBox.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
            ],
          ),
        ),
      ),
    );
  }
}
