import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/schedule/presentation/view/schedule_screen.dart';
import 'package:swit/features/study/schedule/presentation/widgets/calendar.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/action_icon_button.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        appbarTitle: '스터디',
        contentColor: ColorBox.black,
        actions: [
          ActionIconButton(
              svgAsset: 'assets/icons/headset.svg',
              onTap: () {
                Get.toNamed(Routes.STUDY + Routes.AUDIO);
              }),
          // const CustomGap(8),
          // const Icon(Icons.notifications_none_rounded),
          const CustomGap(16),
          ActionIconButton(
              svgAsset: 'assets/icons/setting.svg',
              onTap: () {
                Get.toNamed(Routes.STUDY + Routes.SETTING);
              }),
          const CustomGap(16),
        ],
      ),
      body: Stack(
        children: [Positioned(
            top: 50,
            right: 30,
            child: GestureDetector(
              onTap: () {
                Get.to(() => ScheduleScreen());
              },
              child: Container(
                  width: 100,
                  height: 80,
                  child: Image.asset('assets/images/calendar.png')),
            ))],
      ),
    );
  }
}
