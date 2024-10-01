import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/features/record/presentation/widgets/handle_task_form.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class AddTaskScreen extends GetView<RecordViewModel> {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        backgroundColor: ColorBox.white,
        appBar: CustomBackAppBar(
          backgroundColor: controller.editingTask.color,
          appbarTitle: '',
          isLeading: true,
          isCenterTitle: false,
          actions: [
            Obx(() => TextButton(
                  onPressed: () async {
                    controller.isFormValid
                        ? await controller.onSavePressed()
                        : null;
                    Get.back();
                  },
                  child: Text(
                    '저장',
                    style: FontBox.B1.copyWith(
                        color: controller.isFormValid
                            ? ColorBox.white
                            : ColorBox.grey[300]),
                  ),
                ))
          ],
        ),
        body: const HandleTaskForm(),
      ),
    );
  }
}
