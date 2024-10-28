import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/optimized_profile_image.dart';

class UserCard extends GetView<MateViewModel> {
  final User user;
  final double? width;
  final double? height;

  const UserCard({
    super.key,
    required this.user,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () {
          customDialog(
            context,
            80,
            user.username,
            TextButton(
              onPressed: () async {
                await controller.unfollowMate(user.uid);
                Get.back();
              },
              child: const Text('메이트 해제'),
            ),
            const SizedBox(),
          );
        },
        child: Row(
          children: [
            user.profileUrl != null && user.profileUrl!.isNotEmpty
                ? OptimizedProfileImage(
              imageUrl: user.profileUrl!,
              width: width ?? 40,
              height: height ?? 40,
            )
                : Container(
              width: width ?? 40,
              height: height ?? 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,  // 원형으로 변경
                color: ColorBox.grey.withOpacity(0.5),
              ),
              child: Icon(Icons.person, size: 30, color: ColorBox.white),
            ),
            const CustomGap(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username ?? '이름이 없습니다.',
                    style: FontBox.B2.copyWith(color: ColorBox.black),
                  ),
                  const CustomGap(4),
                  user.introduction?.isEmpty == false
                      ? Text(
                    user.introduction!,
                    style: FontBox.B3.copyWith(color: ColorBox.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
