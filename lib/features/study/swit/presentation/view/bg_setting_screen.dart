import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/enums/bg_theme.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/bg_setting_view_model.dart';
import 'package:swit/features/study/swit/presentation/widgets/build_background.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/action_icon_button.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_column.dart';

class BgSettingScreen extends GetView<BgSettingViewModel> {
  const BgSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorBox.secondColor,
      appBar: const CustomBackAppBar(
        appbarTitle: '배경화면 편집',
        isLeading: true,
        isCenterTitle: true,
        actions: [TextButton(onPressed: null, child: Text('선택'))],
      ),
      body: Column(
        children: [
          Expanded(child: BuildBackground()),
          Obx(() =>
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TapColumn(
                      // widget: Icon(CupertinoIcons.sun_max,
                      //     size: IconSize.xl,
                      //     color: controller.editingTheme == BgTheme.day
                      //         ? ColorBox.primaryColor
                      //         : ColorBox.grey),
                      // onTap: () {
                      //   controller.updateEditingTheme(BgTheme.day);
                      // }
                        widget: ActionIconButton(
                            svgAsset: 'assets/icons/background/day.svg',
                            colorFilter: controller.editingTheme == BgTheme.day
                                ? ColorFilter.mode(ColorBox.primaryColor, BlendMode.srcIn)
                                : ColorFilter.mode(ColorBox.grey, BlendMode.srcIn)),
                        onTap: () {
                          controller.updateEditingTheme(BgTheme.day);
                        }),
                    TapColumn(
                        widget: ActionIconButton(
                            svgAsset: 'assets/icons/background/night.svg',
                            colorFilter: controller.editingTheme == BgTheme.night
                                ? ColorFilter.mode(ColorBox.primaryColor, BlendMode.srcIn)
                                : ColorFilter.mode(ColorBox.grey, BlendMode.srcIn)),
                        onTap: () {
                          controller.updateEditingTheme(BgTheme.night);
                        }),
                    TapColumn(
                        widget: ActionIconButton(
                          // width: 16,
                          // height: 16,
                            svgAsset: 'assets/icons/background/background.svg',
                            colorFilter: controller.editingTheme == BgTheme.custom
                                ? ColorFilter.mode(ColorBox.primaryColor, BlendMode.srcIn)
                                : ColorFilter.mode(ColorBox.grey, BlendMode.srcIn)
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
