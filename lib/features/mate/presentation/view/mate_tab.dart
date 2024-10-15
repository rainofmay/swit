import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/user/presentation/view/profile_edit_screen.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/mate/presentation/widgets/profile_img.dart';
import 'package:swit/features/mate/presentation/widgets/user_card.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_circular_indicator.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class MateTab extends GetView<MateViewModel> {
  MateTab({super.key});

  final _loginService = Get.find<LoginService>();

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

              /* -- 내 프로필 이미지 --*/
              ProfileImg(
                    onTap: () => Get.toNamed(Routes.MATE + Routes.EDITPROFILE),
                    width: 55,
                    height: 55,
                  ),

              /* -- 내 프로필 정보 --*/
              Obx(
                () => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_loginService.isLoggedIn == false)
                          Text('로그인을 해주세요.',
                              style: FontBox.B1.copyWith(color: ColorBox.grey))
                        else if (controller.username.trim().isEmpty)
                          Text('이름을 설정해 주세요.',
                              style: FontBox.B1.copyWith(color: ColorBox.grey))
                        else
                          Text(controller.username.trim(), style: FontBox.B1),
                        const CustomGap(6),
                        // SizedBox(
                        //
                        //   child: Text(
                        //     viewModel.introduction.value.isEmpty
                        //         ? "소개를 작성해 보세요."
                        //         : viewModel.introduction.value,
                        //     style: const TextStyle(fontSize: 11, color: GREY),
                        //     overflow: TextOverflow.ellipsis,
                        //     maxLines: 2,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
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
            // Text('(${viewModel.mateProfiles.length})',
            //     style: FontBox.B2.copyWith(color: ColorBox.dark)),
            const CustomGap(16),
            Expanded(
                child:
                    Container(color: ColorBox.grey.withOpacity(0.3), height: 1))
          ],
        ),
      ),
      const CustomGap(16),

      /* -- 팔로워, 팔로잉 프로필 리스트 --*/
      profileList(context),
    ]);
  }

  Widget profileList(BuildContext context) {
    return Expanded(
      child: Obx(() => RefreshIndicator(
            backgroundColor: ColorBox.white,
            color: ColorBox.primaryColor,
            onRefresh: () async {
              // await viewModel.updateMyProfile();
              // await viewModel.getMyMate();
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
