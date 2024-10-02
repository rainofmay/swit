import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_alert_dialog.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class ProfileCard extends GetView<MateViewModel> {
  final User user;
  final double? width;
  final double? height;

  const ProfileCard(
      {super.key, required this.user, this.width, this.height,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                      title: user.username,
                      width: 160,
                      height: 80,
                      contents: TextButton(onPressed: () async {
                        await controller.unfollowMate(user.uid);
                        Get.back();
                      }, child: const Text('메이트 해제')),
                      actionWidget: const SizedBox());
                });
          },
          child: Row(
            children: [
              Container(
                width: width ?? 36, // 원하는 너비
                height: height ?? 36, // 원하는 높이
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14), // 모서리 둥글기 조절
                  color: ColorBox.grey.withOpacity(0.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Container와 동일한 둥글기
                  child: user.profileUrl != null &&
                      user.profileUrl!.isNotEmpty
                      ? Image.network(
                    user.profileUrl!,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.person, size: 30, color: ColorBox.white),
                ),
              ),
              const CustomGap(10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.username ?? '이름이 없습니다.',
                        style: FontBox.B2.copyWith(color: ColorBox.black)),
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
          )),
    );
  }
}
