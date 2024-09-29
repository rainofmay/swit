import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/mate/presentation/widgets/profile_card.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class MateAddScreen extends GetView<MateViewModel> {
  const MateAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
          appbarTitle: '메이트 추가',
          isLeading: true,
          isCenterTitle: false,
          backFunction: () {
            Get.back();
            controller.initSearch();
          },
          actions: [
            TextButton(
                onPressed: () async {
                  await controller.searchMate();
                },
                child: const Text('검색'))
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const CustomGap(16),
              Obx(() => CustomTextFormField(
                    controller: controller.searchController,
                    fieldWidth: MediaQuery.of(context).size.width * 0.9,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.search,
                    // 키패드에서 검색 버튼 터치했을 때 실행되는 함수
                    onFieldSubmitted: (_) async {
                      await controller.searchMate();
                    },
                    isReadOnly: false,
                    hintText: "메이트 E-mail을 입력해 주세요",
                    onChanged: null,

                    suffixWidget: GestureDetector(
                      onTap: () {
                        controller.searchController.text = "";
                      },
                      child: Icon(Icons.cancel_rounded,
                          size: 15, color: ColorBox.grey),
                    ),
                  )),
              const CustomGap(16),
              Obx(() => controller.searchedMate != null
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorBox.secondColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: ProfileCard(
                                    user: controller.searchedMate!)),

                            // 내가 아닌 다른 사람일 경우에만 follow 버튼 보이기
                            if (!controller
                                .isCurrentUser(controller.searchedMate))

                              Obx(() => controller.isFollowing(controller.searchedMate)
                                  ? _unfollowButton(controller.searchedMate!.uid)
                                  : _followButton()
                              )
                          ],
                        ),
                      ))
                  : SizedBox(
                      child: Text('검색 결과가 없습니다.'),
                    ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _followButton() {
    return TextButton(
        onPressed: () async {
          await controller.followMate();
        },
        child: Text('🩵Follow'));
  }

  Widget _unfollowButton(String mateId) {
    return TextButton(
        onPressed: () async {
          await controller.unfollowMate(mateId);
        },
        child: Text('💔Unfollow'));
  }
}
