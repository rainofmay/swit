import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/app/config/app_config.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,  // 상단 정렬
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  final isToday = controller.selectedDate.day == DateTime.now().day;
                  return SizedBox(
                    width: 60,
                    height: 80,  // 높이를 더 크게 설정
                    child: Column(
                      children: [
                        Text(
                          DateFormat('E').format(controller.selectedDate).toUpperCase(),
                          style: FontBox.B3.copyWith(
                            color: isToday ? ColorBox.primaryColor : ColorBox.grey,
                          ),
                        ),
                        const CustomGap(4),
                        _buildDayText(controller.selectedDate),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: ConstrainedBox(  // 최소 높이 설정
              constraints: const BoxConstraints(minHeight: 80),
              child: Obx(() => controller.selectedDateSchedules.isNotEmpty
                  ? ListView.builder(
                shrinkWrap: true,
                itemCount: controller.selectedDateSchedules.length,
                itemBuilder: (BuildContext context, int index) {
                  final schedule = controller.selectedDateSchedules[index];
                  return _scheduleCard(schedule, context);
                },
              )
                  : Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    'No Schedules',
                    style: FontBox.B1.copyWith(color: ColorBox.grey),
                  ),
                ),
              )
              ),
            ),
          ),
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 빈 영역도 터치되도록

      // 수정 페이지 들어갈 때,
      onTap: () {
        controller.updateEditingSchedule(schedule);
        Get.toNamed(Routes.STUDY + Routes.SCHEDULE + Routes.EDITSCHEDULE);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Container(
          margin: const EdgeInsets.only(right:4),
          decoration: BoxDecoration(
            color: schedule.sectionColor,
                borderRadius: BorderRadius.circular(4)
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(schedule.scheduleName, style: FontBox.B1.copyWith(color: ColorBox.white), overflow: TextOverflow.ellipsis),
                const CustomGap(6),
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
                  style: FontBox.B3.copyWith(color: ColorBox.white, fontFamily: AppConfig.SECOND_FONT_STYLE),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}