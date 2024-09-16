import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/schedule/presentation/widgets/calendar.dart';
import 'package:swit/shared/widgets/action_icon_button.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_row.dart';

class SwitScreen extends StatelessWidget {
  const SwitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
        appbarTitle: 'Study with me',
        isLeading: true,
        isCenterTitle: true,
        actions: [
          ActionIconButton(svgAsset: 'assets/icons/setting.svg', onTap: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              const CustomGap(40),
              TapRow(
                  title: '배경화면',
                  onTap: () {
                    Get.toNamed(Routes.STUDY +
                        Routes.SWIT +
                        Routes.BACKGROUNDSETTING);
                  }),
              const CustomGap(40),
              TapRow(title: '타이머', onTap: () {}),
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
