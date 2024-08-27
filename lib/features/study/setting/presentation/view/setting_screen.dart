import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/schedule/presentation/widgets/calendar.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_row.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(appbarTitle: '설 정', isLeading: true, isCenterTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left:16.0, right:16.0),
          child: Column(
            children: [
              TapRow(title: '배경화면', onTap: () {
                Get.toNamed(Routes.STUDY + Routes.SETTING + Routes.BACKGROUNDSETTING);
              }),
              const CustomGap(16),
              Text('타이머'),
              const CustomGap(16),
              Text('D-day'),
              const CustomGap(16),
              Text('문구'),
              const CustomGap(16),
              Text('알림'),
            ],
          ),
        ),
      ),
    );
  }
}
