import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/core/di/sound_binding.dart';
import 'package:swit/features/study/audio/audio_window.dart';
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
        backgroundColor: ColorBox.transparent,
        contentColor: ColorBox.black,
        actions: [
          ActionIconButton(
              svgAsset: 'assets/icons/headset.svg',
              onTap: () {
                SoundBinding().dependencies();
                Get.dialog(const AudioWindow());
              }),
          // const CustomGap(8),
          // const Icon(Icons.notifications_none_rounded),
          const CustomGap(16),
          ActionIconButton(
              svgAsset: 'assets/icons/setting.svg',
              onTap: () {
              }),
          const CustomGap(16),
        ],
      ),
    );
  }
}
