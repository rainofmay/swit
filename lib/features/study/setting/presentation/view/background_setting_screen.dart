import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_column.dart';

class BackgroundSettingScreenScreen extends StatelessWidget {
  const BackgroundSettingScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(appbarTitle: '배경화면 편집', isLeading: true, isCenterTitle: true),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Text('배경'),
                // 여기에 다른 내용을 추가할 수 있습니다.
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TapColumn(widget: Icon(CupertinoIcons.sun_max, size: IconSize.xl), text: 'Day 모드', onTap: () {}),
                TapColumn(widget: Icon(CupertinoIcons.moon_stars, size: IconSize.xl), text: 'Night 모드', onTap: () {}),
                TapColumn(widget: Icon(CupertinoIcons.photo, size: IconSize.xl), text: '내 앨범', onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
