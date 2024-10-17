import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/mate/presentation/widgets/follow_info.dart';
import 'package:swit/shared/widgets/profile_img.dart';
import 'package:swit/features/mate/presentation/widgets/user_card.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/profile_info.dart';

class MateTab extends GetView<MateViewModel> {
  const MateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* -- 내 프로필 이미지 -- */
              ProfileImg(
                onTap: () => Get.toNamed(Routes.EDITPROFILE),
                width: 55,
                height: 55,
                stackIcon: Icon(Icons.edit_rounded,
                      size: 12, color: ColorBox.primaryColor)
              ),

              /* -- 내 아이디, 소개 -- */
              const ProfileInfo(),

              /* -- 팔로워, 팔로잉 수 정보 -- */
              const FollowInfo()
            ],
          ),
        ),
      ),
      const CustomGap(16),
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            Text('Mates', style: FontBox.B2.copyWith(color: ColorBox.dark)),
            const CustomGap(16),
            Expanded(
                child:
                Container(color: ColorBox.grey.withOpacity(0.3), height: 1))
          ],
        ),
      ),
      const CustomGap(16),

      /* -- 팔로워, 팔로잉 프로필 리스트 -- */
      profileList(context),
    ]);
  }

  Widget profileList(BuildContext context) {
    return Expanded(
      child: Obx(() => RefreshIndicator(
        backgroundColor: ColorBox.white,
        color: ColorBox.primaryColor,
        onRefresh: () async {
          await controller.refreshFollowingList();
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: UserCard(
                      user: controller.followingList[index],
                    ),
                  );
                },
                childCount: controller.followingList.length,
              ),
            ),
          ],
        ),
      )),
    );
  }
}