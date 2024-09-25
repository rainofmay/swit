import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/mate/presentation/viewmodel/post_tab_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:table_calendar/table_calendar.dart';

class MateCalendar extends GetView<PostTabViewModel> {
  const MateCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TableCalendar(
          calendarFormat: controller.calendarFormat,
          availableGestures: AvailableGestures.horizontalSwipe,
          // AvailableGestures.all 은 상위 제스쳐를 무시하므로 none으로 설정
          // locale: 'ko_KR',
          daysOfWeekHeight: 50,
          focusedDay: controller.focusedDate,
          currentDay: controller.selectedDate,
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
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey.shade300, width: 0.5),
                //   color: ColorBox.white,
                // ),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(day.day.toString(), style: FontBox.B3),
                    )));
          },
              // 해당 주, 또는 월에서 벗어나는 날짜
              outsideBuilder: (context, day, focusedDay) {
            return Container(
              child: Align(
                  alignment: Alignment.topLeft,
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
                alignment: Alignment.topLeft,
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
            // if (viewModel.getEvents(day).isEmpty) {
            //   null;
            // } else if (viewModel.getEvents(day).isNotEmpty && viewModel.getEvents(day).length < 5) {
            //   return ListView.builder(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       itemCount: events.length,
            //       itemBuilder: (context, index) {
            //         Event event = events[index] as Event;
            //         int colorIndex = viewModel.getEventsColor(day)[event.id] ?? 0;
            //         Color eventColor = sectionColors[colorIndex];
            //         return Container(
            //           margin: const EdgeInsets.only(top: 35),
            //           child: Icon(
            //             size: 8,
            //             Icons.circle,
            //             color: eventColor,
            //           ),
            //         );
            //       });
            // } else if (viewModel.getEvents(day).length >= 5) {
            //   return Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(right: 2.0),
            //         child: Container(
            //           width: 18,
            //           height: 15,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(3),
            //             color: DARK_BACKGROUND,
            //           ),
            //           child: Text(
            //             '${viewModel.getEvents(day).length}',
            //             style: const TextStyle(fontSize: 9, color: PRIMARY_LIGHT),
            //             textAlign: TextAlign.center,
            //           ),
            //         ),
            //       )
            //     ],
            //   );
            // }
            // return null;
          }),

          // 달력에 이벤트 업로드
          // eventLoader: viewModel.getEvents,

          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            // 달력 크기 선택 옵션 없애기
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: ColorBox.black,
              size: 18,
            ),
            // 왼쪽 화살표 색상
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: ColorBox.black,
              size: 18,
            ),
            titleTextStyle: FontBox.B1,
          ),

          // 요일 날짜 스타일
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: FontBox.B2,
            weekendStyle: FontBox.B2,
          ),

          calendarStyle: const CalendarStyle(
            outsideDaysVisible: true,
            isTodayHighlighted: false,
          ),

          // 날짜가 선택됐을 때 실행할 함수
          onPageChanged: (DateTime focusedDay) {},

          // 기간 선택 모드
          rangeSelectionMode: RangeSelectionMode.toggledOff,

          onRangeSelected:
              (DateTime? start, DateTime? end, DateTime focusedDay) {},
        ));
  }
}
