
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/color_section.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class ScheduleForm extends GetView<ScheduleViewModel> {
  ScheduleForm({super.key});

  final ScheduleViewModel viewModel = Get.find<ScheduleViewModel>();

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding:
        // appBar와 body 간의 간격
        const EdgeInsets.only(
          left: 8.0,
          top: 16.0,
        ),
        child: Obx(() => Column(
          children: [
            CustomTextFormField(
              autofocus: false,
              textInputAction: TextInputAction.done,
              isReadOnly: false,
              controller: controller.titleController,
              titleIcon: IconButton(
                  icon: Icon(CupertinoIcons.circle_filled,
                      color: controller.editingColor),
                  onPressed: () => customDialog(
                    context,
                    240,
                    '구분 색상',
                    Column(children: [
                      ColorSelection(),
                    ]),
                    TextButton(
                      child: Text('확인',
                          style: TextStyle(color: ColorBox.white)),
                      onPressed: () {
                        // _sectionColor = viewModel.colorIndex;
                        Navigator.of(context).pop();
                      },
                    ),
                  )),
              hintText: '일정을 입력해 주세요.',
              maxLines: 1,
              maxLength: 60,
              onChanged: (_) => viewModel.updateFormValidity(),
              fieldWidth:  MediaQuery.of(context).size.width * 0.7,
              isPasswordField: false,
              keyboardType: TextInputType.multiline,
            ),


            // 시작 일시
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    autofocus: false,
                    isReadOnly: true,
                    onTap: () {
                      getDateFromUser(
                          context: context, isStartTime: true, viewModel: viewModel);
                    },
                    titleIcon: const IconButton(
                        icon: Icon(
                          Icons.edit_calendar_outlined,
                          color: BLACK,
                        ),
                        onPressed: null),
                    hint: DateFormat.yMd().format(viewModel.nowHandlingScheduleModel.startDate),
                  ),
                ),
                viewModel.nowHandlingScheduleModel.isTimeSet
                    ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: CustomTextField(
                        onTap: () {
                          getDateFromUser(
                              context: context, isStartTime: true, viewModel: viewModel);
                        },
                        autofocus: false,
                        textAlign: TextAlign.right,
                        readOnly: true,
                        hint: DateFormat('hh:mm a').format(viewModel.nowHandlingScheduleModel.startDate),
                      ),
                    ))
                    : const SizedBox(),
              ],
            ),

            // 종료 일시
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    autofocus: false,
                    isReadOnly: true,
                    onTap: () {
                      getDateFromUser(
                          context: context, isStartTime: false, viewModel: viewModel);
                    },
                    titleIcon: IconButton(
                        icon: Icon(
                          Icons.edit_calendar_outlined,
                          color: TRANSPARENT,
                        ),
                        onPressed: null),
                    hint: DateFormat.yMd().format(viewModel.nowHandlingScheduleModel.endDate),
                    hintStyle: viewModel.nowHandlingScheduleModel.endDate.isBefore(viewModel.nowHandlingScheduleModel.startDate)
                        ? const TextStyle(color: RED)
                        : const TextStyle(),
                  ),
                ),
                viewModel.nowHandlingScheduleModel.isTimeSet
                    ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: CustomTextField(
                        onTap: () {
                          getDateFromUser(
                              context: context, isStartTime: false, viewModel: viewModel);
                        },
                        autofocus: false,
                        textAlign: TextAlign.right,
                        readOnly: true,
                        hint: DateFormat('hh:mm a').format(viewModel.nowHandlingScheduleModel.endDate),
                        hintStyle: viewModel.nowHandlingScheduleModel.endDate.isBefore(viewModel.nowHandlingScheduleModel.startDate) || viewModel.nowHandlingScheduleModel.endDate.isAtSameMomentAs(viewModel.nowHandlingScheduleModel.startDate)
                            ? const TextStyle(color: RED)
                            : const TextStyle(),
                      ),
                    ))
                    : const SizedBox(),
              ],
            ),


            Padding(
              padding: const EdgeInsets.only(right: 13.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Time'),
                  const SizedBox(width: 3),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: viewModel.nowHandlingScheduleModel.isTimeSet,
                      activeColor: Color(0xff8FB8EE),
                      //Color(0xffC8D8FA)
                      onChanged: (bool? value) {
                        viewModel.toggleTimeSet();
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 완료 여부
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  // Icon
                  TapableRow(
                      widget: viewModel
                          .nowHandlingScheduleModel.isDone
                          ? Padding(
                        padding: const EdgeInsets.only(right:16.0),
                        child: const Icon(Icons.check_box_rounded),
                      )
                          : Padding(
                        padding: const EdgeInsets.only(right:16.0),
                        child: const Icon(
                            Icons.check_box_outline_blank_rounded),
                      ),
                      title: viewModel.nowHandlingScheduleModel.isDone
                          ? '일정 완료'
                          : '일정 진행',
                      onTap: () {
                        viewModel.setIsDone(!viewModel
                            .nowHandlingScheduleModel.isDone);
                      }),
                ],
              ),
            ),

          ],
        )),
      ),
    );
  }
}
