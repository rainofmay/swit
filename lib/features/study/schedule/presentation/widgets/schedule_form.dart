
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/color_section.dart';
import 'package:swit/features/study/schedule/presentation/widgets/pick_date.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class ScheduleForm extends GetView<ScheduleViewModel> {
  const ScheduleForm({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              autofocus: true,
              isReadOnly: false,
              controller: controller.titleController,
              titleIcon: IconButton(
                  icon: Icon(CupertinoIcons.circle_filled,
                      color: controller.editingSchedule.sectionColor),
                  onPressed: () => customDialog(
                    context,
                    240,
                    '구분 색상',
                    Column(children: [
                      ColorSelection(),
                    ]),
                    TextButton(
                      child: const Text('확인',
                          style: FontBox.H5),
                      onPressed: () {
                        controller.updateScheduleColor(controller.editingSchedule.sectionColor);
                        Get.back();
                      },
                    ),
                  )),
              hintText: '일정을 입력해 주세요.',
              maxLines: 1,
              maxLength: 60,
              textStyle: FontBox.H4,
              onChanged: (value) {
                controller.checkFormValidity();
                controller.updateScheduleName(value);
              },
              fieldWidth:  MediaQuery.of(context).size.width * 0.7,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              inputBorder: InputBorder.none,
            ),

            const CustomGap(16),
            Divider(height: 1, color: ColorBox.grey[300]),
            const CustomGap(16),

            /* -- 시작 일시 -- */
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: CustomTextFormField(
                    autofocus: false,
                    isReadOnly: true,
                    onTap: () {
                      pickDate(
                          context: context, isStartTime: true);
                    },
                    titleIcon: IconButton(
                        icon: Icon(
                          Icons.edit_calendar_outlined,
                          color: ColorBox.black,
                        ),
                        onPressed: null),
                    hintText: DateFormat.yMd().format(controller.editingSchedule.from),
                    hintStyle: controller.editingSchedule.to.isBefore(controller.editingSchedule.from)
                        ? TextStyle(color: ColorBox.darkRed)
                        : const TextStyle(),
                    inputBorder: InputBorder.none,
                  ),
                ),
                controller.editingSchedule.isAllDay
                    ? const SizedBox() : Expanded(
                  flex: 2,
                    child: CustomTextFormField(
                      onTap: () {
                        pickDate(
                            context: context, isStartTime: true);
                      },
                      autofocus: false,
                      isReadOnly: true,
                      hintText: DateFormat('hh:mm a').format(controller.editingSchedule.from),
                      hintStyle: controller.editingSchedule.to.isBefore(controller.editingSchedule.from)
                          ? TextStyle(color: ColorBox.darkRed)
                          : const TextStyle(),
                      inputBorder: InputBorder.none,
                    )),
              ],
            ),
            const CustomGap(8),

            /* -- 종료 일시 -- */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: CustomTextFormField(
                    autofocus: false,
                    isReadOnly: true,
                    onTap: () {
                      pickDate(
                          context: context, isStartTime: false);
                    },
                    titleIcon: IconButton(
                        icon: Icon(
                          Icons.edit_calendar_outlined,
                          color: ColorBox.transparent,
                        ),
                        onPressed: null),
                    hintText: DateFormat.yMd().format(controller.editingSchedule.to),
                    hintStyle: controller.editingSchedule.to.isBefore(controller.editingSchedule.from)
                        ? TextStyle(color: ColorBox.darkRed)
                        : const TextStyle(),
                    inputBorder: InputBorder.none,
                  ),
                ),
                controller.editingSchedule.isAllDay
                    ?  const SizedBox() : Expanded(
                  flex: 2,
                      child: CustomTextFormField(
                        onTap: () {
                          pickDate(
                              context: context, isStartTime: false);
                        },
                        autofocus: false,
                        isReadOnly: true,
                        hintText: DateFormat('hh:mm a').format(controller.editingSchedule.to),
                        hintStyle: controller.editingSchedule.to.isBefore(controller.editingSchedule.from)
                            ? TextStyle(color:  ColorBox.darkRed)
                            : const TextStyle(),
                        inputBorder: InputBorder.none,
                      ),
                    ),
              ],
            ),
            CustomGap(8),

            /* -- 시간 설정 -- */
            Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('하루 종일', style: FontBox.B1.copyWith(letterSpacing: 1)),
                  const SizedBox(width: 3),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: controller.editingSchedule.isAllDay,
                      activeColor: const Color(0xff8FB8EE),
                      //Color(0xffC8D8FA)
                      onChanged: (bool value) {
                        controller.updateScheduleIsAllDay(value);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const CustomGap(16),
            Divider(height: 1, color: ColorBox.grey[300]),
            const CustomGap(16),

            /* -- description -- */
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 16),
                  child: Icon(Icons.sticky_note_2_outlined, size: IconSize.md),
                ),
                // IconButton(onPressed: (){}, icon: Icon(Icons.sticky_note_2_outlined,  size: IconSize.md,)),
                CustomTextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  isReadOnly: false,
                  controller: controller.descriptionController,
                  hintText: '메모를 입력해 보세요.',
                  inputBorder: InputBorder.none,
                  maxLines: 10,
                  maxLength: 900,
                  onChanged: (value) {
                    controller.checkFormValidity();
                    controller.updateScheduleDescription(value);
                  },
                  fieldWidth: MediaQuery.of(context).size.width * 0.7,
                ),
              ],
            ),

            // 완료 여부
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            //   child: Row(
            //     children: [
            //       // Icon
            //       TapableRow(
            //           widget: viewModel
            //               .nowHandlingScheduleModel.isDone
            //               ? Padding(
            //             padding: const EdgeInsets.only(right:16.0),
            //             child: const Icon(Icons.check_box_rounded),
            //           )
            //               : Padding(
            //             padding: const EdgeInsets.only(right:16.0),
            //             child: const Icon(
            //                 Icons.check_box_outline_blank_rounded),
            //           ),
            //           title: viewModel.nowHandlingScheduleModel.isDone
            //               ? '일정 완료'
            //               : '일정 진행',
            //           onTap: () {
            //             viewModel.setIsDone(!viewModel
            //                 .nowHandlingScheduleModel.isDone);
            //           }),
            //     ],
            //   ),
            // ),

          ],
        )),
      ),
    );
  }
}
