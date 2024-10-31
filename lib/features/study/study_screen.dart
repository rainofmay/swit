import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/action_icon_button.dart';

import 'swit/presentation/viewmodel/bg_setting_view_model.dart';

class StudyScreen extends GetView<BgSettingViewModel> {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // appbar 배경색이 배경이미지에 덮히도록
      appBar: CustomAppBar(
        appbarTitle: '스터디',
        backgroundColor: ColorBox.transparent,
        actions: [
          ActionIconButton(
              svgAsset: 'assets/icons/notification.svg',
              onTap: () async {
                Get.toNamed(Routes.STUDY + Routes.NOTIFICATION);
              }),
          const CustomGap(16),

          ActionIconButton(
              svgAsset: 'assets/icons/headset.svg',
              onTap: () async {
                Get.toNamed(Routes.STUDY + Routes.AUDIO);
              }),
          const CustomGap(16),

          ActionIconButton(
              svgAsset: 'assets/icons/setting.svg',
              onTap: () {
                Get.toNamed(Routes.STUDY + Routes.SWIT);
              }),
          const CustomGap(16),
        ],
      ),
      body: Stack(
        children: [
          SizedBox.expand(
              child: Obx(() => Image.asset(controller.bgThemeMap[controller.editingTheme]!, fit: BoxFit.cover))),

          Positioned(
            top: 70,
            right: 30,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.STUDY + Routes.SCHEDULE);
              },
              child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset('assets/images/calendar.png'),
              ))),
        ],
      ),
    );
  }
}
