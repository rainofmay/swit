import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/schedule_form.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class EditScheduleScreen extends GetView<ScheduleViewModel> {
  const EditScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=> CustomScaffold(
        appBar: CustomBackAppBar(
            appbarTitle: '',
            isLeading: true,
            isCenterTitle: true,
            backgroundColor: controller.editingSchedule.sectionColor,
            backFunction: () {
              // 뒤로가면 editingSchedule 초기화
              controller.initNewSchedule();
              Get.back();
            },
            actions: [
              Obx(() => TextButton(
                  onPressed: () async {
                    controller.isFormValid
                        ? await controller.onUpdatePressed()
                        : null;
                    Get.back();
                  },
                  child: Text('수정',
                      style: FontBox.CONTENTSTYLE.copyWith(
                          color: controller.isFormValid
                              ? ColorBox.black
                              : ColorBox.grey)))),
              TextButton(
                  onPressed: () async {
                    await controller.deleteSchedule();
                    Get.back();
                  },
                  child: Text('삭제',
                      style: FontBox.CONTENTSTYLE
                          .copyWith(color: ColorBox.darkRed)))
            ]),
        body: SafeArea(child: ScheduleForm())));
  }
}
