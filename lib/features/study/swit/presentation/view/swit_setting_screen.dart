import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_setting_view_model.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/custom_switch.dart';
import 'package:swit/shared/widgets/tap_row.dart';

class SwitSettingScreen extends GetView<SwitSettingViewModel> {
  const SwitSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
          appbarTitle: '설 정', isLeading: true, isCenterTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              const CustomGap(40),
              TapRow(
                  title: '배경화면',
                  onTap: () {
                    Get.toNamed(Routes.STUDY +
                        Routes.SWIT +
                        Routes.SWITSETTING +
                        Routes.BACKGROUNDSETTING);
                  },
                  action: Icon(CupertinoIcons.forward)),
              const CustomGap(40),
              Obx(() => TapRow(
                  title: '타이머',
                  action: CustomSwitch(
                      value: controller.isTimer,
                      onChanged: controller.toggleIsTimer,
                  ))),
              const CustomGap(40),
              TapRow(title: 'D-day', onTap: () {}),
              const CustomGap(40),
              TapRow(title: '문구', onTap: () {}),
              const CustomGap(40),
              TapRow(title: '알림', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
