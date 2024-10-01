import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/color_section.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class HandleTaskForm extends GetView<RecordViewModel> {
  const HandleTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => CustomTextFormField(
              controller: controller.taskTitleController,
              titleIcon: IconButton(
                  icon: Icon(CupertinoIcons.circle_filled,
                      color: controller.editingTask.color),
                  onPressed: () => customDialog(
                    context,
                    240,
                    '구분 색상',
                    Column(children: [
                      ColorSelection(),
                    ]),
                    TextButton(
                      child: const Text('확인', style: FontBox.H5),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  )),
              autofocus: true,
              isReadOnly: false,
              hintText: '과제 이름을 입력해 주세요.',
              textStyle: FontBox.H4,
              onChanged: (value) {
                controller.checkFormValidity();
                // controller.updateScheduleName(value);
              },
              fieldWidth: MediaQuery.of(context).size.width * 0.7,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ))
          ],
        ),
      ),
    );
  }
}
