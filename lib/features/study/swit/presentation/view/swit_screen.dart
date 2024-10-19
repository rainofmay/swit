import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/swit/presentation/view/create_swit_screen.dart';
import 'package:swit/shared/widgets/profile_img.dart';
import 'package:swit/features/study/schedule/presentation/widgets/calendar.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ActionIconButton(svgAsset: 'assets/icons/setting.svg', onTap: () {
              Get.toNamed(Routes.STUDY + Routes.SWIT + Routes.SWITSETTING);
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Get.toNamed(Routes.STUDY + Routes.SWIT + Routes.CREATESWIT);
        },
        child: Icon(Icons.person_add_alt_1, color: ColorBox.black),
        elevation: 1,
        backgroundColor: ColorBox.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomGap(40),
          Text('Here is Swit.', style: FontBox.H4),
          const CustomGap(16),
          Text('From ${DateFormat('yyyy.MM.dd').format(DateTime.now())}', style: FontBox.B1),
          const CustomGap(32),
          Container(
              width: 180,
              height: 180,
              child: Image.asset('assets/images/logo.png')),
          const CustomGap(32),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: ColorBox.secondColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImg(width: 50, height: 50, onTap: null,),
                    const CustomGap(8),
                    Text('User ID', style: FontBox.B3)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
