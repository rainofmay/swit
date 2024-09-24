import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/study/schedule/domain/entities/event.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/pick_month_year.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends GetView<ScheduleViewModel> {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TableCalendar(
      calendarFormat: controller.calendarFormat,
      availableGestures: AvailableGestures.horizontalSwipe,
      // AvailableGestures.all 은 상위 제스쳐를 무시하므로 none으로 설정
      // locale: 'ko_KR',
      daysOfWeekHeight: 28, // 요일 구분하는 박스의 높이
      rowHeight: 65, // 날짜 cell의 높이
      focusedDay: controller.focusedDate,
      currentDay: controller.selectedDate,
      onHeaderTapped: (DateTime focusedDay) {
        pickMonthYear(context: context);
      },

      onDaySelected: (selectedDay, focusedDay) {
        controller.updateSelectedDate(selectedDay);
        controller.updateFocusedDate(focusedDay);
      },

      selectedDayPredicate: (day) =>
          isSameDay(controller.selectedDate, day),
      firstDay: DateTime.now().subtract(const Duration(days: 365 * 3)),
      lastDay: DateTime.now().add(const Duration(days: 365 * 20)),

      calendarBuilders: CalendarBuilders(

        // 기본 날짜 스타일
          defaultBuilder: (context, day, focusedDay) {
            return Container(
                child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(day.day.toString(), style: FontBox.B3),
                    )));
          },
          // 해당 주, 또는 월에서 벗어나는 날짜
          outsideBuilder: (context, day, focusedDay) {
            return SizedBox(
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(day.day.toString(),
                        style: FontBox.B3.copyWith(color: ColorBox.grey)),
                  )),
            );
          },

          selectedBuilder: (context, date, _) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: ColorBox.secondColor),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${date.day}',
                    style: FontBox.B3.copyWith(
                        color: ColorBox.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },

          dowBuilder: (context, day) {
            if (day.weekday == DateTime.sunday ||
                day.weekday == DateTime.saturday) {
              final text = DateFormat.E().format(day);
              return Center(
                  child: Text(text,
                      style: FontBox.B2.copyWith(color: ColorBox.red)));
            }
            return null;
          },

          // 이벤트 표시
          markerBuilder: (context, day, events) {
            if (controller.getEvents(day).isEmpty) {
              null;
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    Event event = events[index] as Event;
                    Color? eventColor = controller.getEventsColor(day)[event.id];
                    return Container(
                      margin: const EdgeInsets.only(top: 35),
                      child: Icon(
                        size: 6,
                        Icons.circle,
                        color: eventColor,
                      ),
                    );
                  });
            }
            return null;
          }),

      eventLoader: (day) {
        return controller.getEvents(day);
      },

      headerStyle: const HeaderStyle(
        headerPadding: EdgeInsets.only(left: 16, bottom: 16),
        titleCentered: false,
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: FontBox.B1,
      ),

      // 요일 날짜 스타일
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: FontBox.B2,
        weekendStyle: FontBox.B2,
        decoration: BoxDecoration(
          color: ColorBox.grey[200], // 연한 회색 배경
        ),
      ),

      calendarStyle: const CalendarStyle(
        outsideDaysVisible: true,
        isTodayHighlighted: false,

        /* -- marker -- */
        markersMaxCount: 5,
        markerSize: 6,
      ),

      // 기간 선택 모드
      rangeSelectionMode: RangeSelectionMode.toggledOff,

      onRangeSelected:
          (DateTime? start, DateTime? end, DateTime focusedDay) {},
    ));
  }
}
