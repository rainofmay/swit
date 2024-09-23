import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class ScheduleList extends GetView<ScheduleViewModel> {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: Row(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Obx(() {
              final isToday = controller.selectedDate.day == DateTime.now().day;
              return Container(
                width: 60,
                height: 60,
                child: Column(
                  children: [
                    Text(
                      DateFormat('E')
                          .format(controller.selectedDate)
                          .toUpperCase(),
                      style: FontBox.B3.copyWith(
                        color: isToday
                            ? ColorBox.primaryColor
                            : ColorBox.grey,
                      ),
                    ),
                    CustomGap(isToday ? 4 : 8),
                    _buildDayText(controller.selectedDate),
                  ],
                ),
              );
            })
          ]),
          Obx(() => Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.selectedDateSchedules.length,
                itemBuilder: (BuildContext context, int index) {
                  final schedule = controller.selectedDateSchedules[index];
                  return _scheduleCard(schedule, context);
                },
              ))),
        ],
      ),
    );
  }

  Widget _buildDayText(DateTime date) {
    final bool isToday = date.day == DateTime.now().day;
    final text = Text(
      '${date.day}',
      style: FontBox.B1.copyWith(
        color: isToday ? ColorBox.white : null,
      ),
    );

    if (isToday) {
      return Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ColorBox.primaryColor,
          shape: BoxShape.circle,
        ),
        child: text,
      );
    }

    return text;
  }
  Widget _scheduleCard(Schedule schedule, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque, // 빈 영역도 터치되도록

          // 수정 페이지 들어갈 때,
          onTap: () {
            viewModel.initializeForEditSchedule(schedule);
            Get.toNamed(Routes.STUDY + Routes.SCHEDULE + Routes.EDITSCHEDULE);
          },
          child: Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 30, left: 5, bottom: 15),
              child: Padding(
                padding: const EdgeInsets.only(
                  // 카드 안에서 텍스트의 패딩 간격
                    left: 8,
                    right: 8,
                    top: 12,
                    bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(schedule.scheduleName, style: FontBox.H5),
                    Text(
                      !schedule.isAllDay
                          ? schedule.from.day !=
                          schedule
                              .to.day // 시간 설정 있고, 기간일 때
                          ? schedule.from.year ==
                          schedule.to.year
                          ? '${schedule.from.year}/${schedule.from.month}/${schedule.from.day} ~ ${schedule.to.month}/${schedule.to.day}'
                          : '${schedule.from.year}/${schedule.from.month}/${schedule.from.day} ~ ${schedule.to.year}/${schedule.to.month}/${schedule.to.day}'
                          : '${DateFormat('hh:mm a').format(schedule.from)}~${DateFormat('hh:mm a').format(schedule.to)}' // 하루일 때

                          : schedule.from.day !=
                          schedule
                              .to.day // 시간 설정 없고 기간일 때,
                          ? schedule.from.year ==
                          schedule.to.year
                          ? '${schedule.from.year}/${schedule.from.month}/${schedule.from.day} ~ ${schedule.to.month}/${schedule.to.day}'
                          : '${schedule.from.year}/${schedule.from.month}/${schedule.from.day} ~ ${schedule.to.year}/${schedule.to.month}/${schedule.to.day}'
                          : '${schedule.from.year}/${schedule.from.month}/${schedule.from.day}',
                      style: FontBox.B3.copyWith(color: ColorBox.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

}