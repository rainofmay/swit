import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/schedule_form.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class CreateScheduleScreen extends GetView<ScheduleViewModel> {
  const CreateScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        appBar: CustomBackAppBar(
          appbarTitle: '',
          contentColor: ColorBox.white,
          isLeading: true,
          isCenterTitle: true,
          backgroundColor: controller.editingSchedule.sectionColor,
          actions: [
            Obx(() => TextButton(
              onPressed: () async {
                controller.isFormValid ? await controller.onSavePressed() : null;
                // 이벤트 표시 즉시 렌더링을 위해 필요

                Get.back();
              },
              child: Text('저장',
                  style: controller.isFormValid ? FontBox.activtedActions : FontBox.disabledActions),
            ))
          ],
        ),
        body: SafeArea(child: ScheduleForm())));
  }
}
