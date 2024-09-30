import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/color_section.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class HandleTaskScreen extends GetView<RecordViewModel> {
  const HandleTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        backgroundColor: ColorBox.white,
        appBar: CustomBackAppBar(
          appbarTitle: '과제',
          isLeading: true,
          isCenterTitle: false,
          actions: [
            Obx(() => TextButton(
                  onPressed: () async {
                    // controller.isFormValid
                    //     ? await controller.onSavePressed()
                    //     : null;
                    Get.back();
                  },
                  child: Text(
                    '저장',
                    // style: FontBox.B1.copyWith(
                    //     color: controller.isFormValid
                    //         ? ColorBox.white
                    //         : ColorBox.grey[300]),
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => CustomTextFormField(
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
                    // controller.checkFormValidity();
                    // controller.updateScheduleName(value);
                  },
                  fieldWidth: MediaQuery.of(context).size.width * 0.7,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
