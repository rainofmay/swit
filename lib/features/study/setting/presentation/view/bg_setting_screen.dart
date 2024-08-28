import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/enums/bg_theme.dart';
import 'package:swit/features/study/setting/presentation/viewmodel/bg_setting_view_model.dart';
import 'package:swit/features/study/setting/presentation/widgets/build_background.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_column.dart';

class BgSettingScreen extends GetView<BgSettingViewModel> {
  const BgSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomBackAppBar(
          appbarTitle: '배경화면 편집', isLeading: true, isCenterTitle: true, actions: [TextButton(onPressed: null, child: Text('선택'))],),
      body: Column(
        children: [
          Expanded(child: BuildBackground()),
          Obx(() => Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TapColumn(
                    widget: Icon(CupertinoIcons.sun_max,
                        size: IconSize.xl,
                        color: controller.editingTheme == BgTheme.day
                            ? ColorBox.primaryColor
                            : ColorBox.grey),
                    onTap: () {
                      controller.updateEditingTheme(BgTheme.day);
                    }),
                TapColumn(
                    widget: Icon(CupertinoIcons.moon_stars, size: IconSize.xl,
                        color: controller.editingTheme == BgTheme.night
                            ? ColorBox.primaryColor
                            : ColorBox.grey
                    ),
                    onTap: () {
                      controller.updateEditingTheme(BgTheme.night);
                    }),
                TapColumn(
                    widget: Icon(CupertinoIcons.photo, size: IconSize.xl,
                        color: controller.editingTheme == BgTheme.custom
                            ? ColorBox.primaryColor
                            : ColorBox.grey
                    ),
                    onTap: () {
                      controller.updateEditingTheme(BgTheme.custom);
                    }),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
