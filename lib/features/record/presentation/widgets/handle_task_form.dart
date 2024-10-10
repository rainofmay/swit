import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/color_section.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/constant/theme_color.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
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
              titleIcon: Icon(CupertinoIcons.circle_filled,
                      color: controller.editingTask.color),
              autofocus: true,
              isReadOnly: false,
              hintText: '과제 이름을 입력해 주세요.',
              maxLength: 15,
              textStyle: FontBox.H4,
              onChanged: (value) {
                controller.checkFormValidity();
                controller.updateTaskTitle(value);
              },
              fieldWidth: MediaQuery.of(context).size.width * 0.7,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            )),
            const CustomGap(32),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 200,
              child: GridView.builder(
                // physics: NeverScrollableScrollPhysics(), // 터치 스크롤현상 없애는 것.
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemCount: ThemeColor.colorList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 2.0,
                  //item 의 가로 1, 세로 1 의 비율
                  mainAxisSpacing: 20, // 세로 간격
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => GestureDetector(
                    onTap: () {
                      controller.updateTaskColor(ThemeColor.colorList[index]);
                    },
                    child: CircleAvatar(
                        backgroundColor: ThemeColor.colorList[index],
                        child: controller.editingTask.color == ThemeColor.colorList[index]
                            ? Icon(
                          Icons.check_rounded,
                          color: ColorBox.white,
                          size: 19,
                        )
                            : null),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
