import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_view_model.dart';
import 'package:swit/features/study/swit/presentation/widgets/swit_group_container.dart';
import 'package:swit/features/study/swit/presentation/widgets/wave_back_ground.dart';
import 'package:swit/shared/widgets/my_profile_img.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/action_icon_button.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_row.dart';

class SwitScreen extends GetView<SwitViewModel> {
  const SwitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBackAppBar(
        appbarTitle: 'Study with me',
        isLeading: true,
        isCenterTitle: true,
        backgroundColor: ColorBox.transparent,
      ),
      body: Stack(
        children: [
          // 물결 배경
          WaveBackground(
            topImagePath: 'assets/images/day_photo.png',
            // topColor: Colors.blue.shade100, // 상단 배경색
            bottomColor: Colors.white, // 하단 배경색
            waveHeight: 28, // 물결 높이
            frequency: 0.8, // 물결 빈도
          ),

          // 실제 내용
          Column(
            children: [
              // 상단 영역 (물결 위)
              Expanded(
                flex: 2,
                child: SafeArea(
                  child: Obx(() {
                    // 로딩 중일 때
                    if (controller.isLoading) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        const CustomGap(64),
                        controller.hasGroup
                            ? SwitGroupContainer()
                            : const Text('참여 중인 그룹스터디가 없습니다.',
                                style: FontBox.B1)
                      ],
                    );
                  }),
                ),
              ),

              // 하단 영역 (물결 아래)
              Expanded(
                flex: 1, // 하단 영역의 비율
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('테스트'),
                            Text(
                                'From ${DateFormat('yyyy.MM.dd').format(DateTime.now())}',
                                style: FontBox.B1),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TapRow(
                                  onTap: () => Get.toNamed(Routes.STUDY +
                                      Routes.SWIT +
                                      Routes.CREATESWIT),
                                  widget: SvgPicture.asset(
                                      'assets/icons/swit/invite_color.svg'),
                                  title: '그룹스터디 생성'),
                            ),
                            const CustomGap(40),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TapRow(
                                  onTap: () => Get.toNamed(Routes.STUDY +
                                      Routes.SWIT +
                                      Routes.SWITPOST),
                                  widget: SvgPicture.asset(
                                      'assets/icons/swit/message_color.svg'),
                                  title: '쪽지 쓰기'),
                            ),
                            const CustomGap(40),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TapRow(
                                  onTap: () => Get.toNamed(
                                      Routes.STUDY + Routes.SCHEDULE),
                                  widget: SvgPicture.asset(
                                      'assets/icons/swit/calendar_color.svg'),
                                  title: '일정 관리'),
                            ),
                            const CustomGap(40),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TapRow(
                                  onTap: () => Get.toNamed(Routes.STUDY +
                                      Routes.SWIT +
                                      Routes.SWITSETTING),
                                  widget: SvgPicture.asset(
                                      'assets/icons/swit/setting_color.svg'),
                                  title: '설 정'),
                            ),
                            // MyProfileImg(
                            //     width: 50, height: 50, onTap: null),
                            // const CustomGap(8),
                            // Text('User ID', style: FontBox.B3)
                          ],
                        ),
                      ],
                    ),
                    // 추가 하단 내용
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
