import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/schedule/schedule_service.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends GetView<ScheduleViewModel> {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isSchedulesLoaded ? SfCalendar(
      view: CalendarView.month,
      dataSource: controller.scheduleService,
      initialSelectedDate: controller.selectedDate,

      monthViewSettings: const MonthViewSettings(
        // 이전/다음 달의 날짜를 표시
        showTrailingAndLeadingDates: true,

        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
        // appointment 텍스트로 표시
        showAgenda: true, // 하단에 이벤트 내용 표시
      ),

      timeSlotViewSettings: TimeSlotViewSettings(
        timeFormat: 'hh:mm a',
        timeInterval: Duration(minutes: 30),
        timeIntervalHeight: 80,
      ),


      // agenda 영역에서 오늘 날짜 색
      todayHighlightColor: Colors.pink,
      //   appointmentBuilder: (context, calendarAppointmentDetails) {
      //   return SvgPicture.asset(
      //     'assets/your_custom_indicator.svg',
      //     width: calendarAppointmentDetails.bounds.width,
      //     height: calendarAppointmentDetails.bounds.height,
      //   );
      // },
      // appointmentBuilder: (context, calendarAppointmentDetails) {
      //   final Schedule schedule = calendarAppointmentDetails.appointments.first;
      //   final bool hasDescription = schedule.description != null;
      //   return Container(
      //     color: schedule.sectionColor.withOpacity(0.8),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           schedule.scheduleName,
      //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //           overflow: TextOverflow.ellipsis,
      //         ),
      //         schedule.description != null ?
      //           Text(
      //             schedule.description!,
      //             style: TextStyle(color: Colors.white70),
      //             overflow: TextOverflow.ellipsis,
      //             maxLines: 1,
      //           ) : SizedBox(),
      //       ],
      //     ),
      //   );
      // },


      // 년, 월 헤더 스타일
      headerStyle: CalendarHeaderStyle(
          backgroundColor: ColorBox.white,
          textStyle:
          FontBox.B1.copyWith(color: ColorBox.primaryColor)),
      // 요일 헤더 스타일
      viewHeaderStyle: ViewHeaderStyle(
        backgroundColor: ColorBox.secondColor,
      ),

      selectionDecoration: BoxDecoration(
        border: Border.all(color: ColorBox.transparent),
      ),

      showDatePickerButton: true,

      onTap: controller.onTap,
      onLongPress: controller.onLongPress,
      monthCellBuilder: (context, details) {
        final currentDate =
        DateTime(details.date.year, details.date.month, details.date.day);
        final isSelected = controller.selectedDateRange.contains(currentDate);
        // 무조건 현재인 달과 비교하여 현재 달의 날짜인지 확인, 다른 달이면 회색 처리
        final isCurrentMonth =
            details.date.month == details.visibleDates[15].month;
        // 선택된 범위의 시작과 끝 날짜 확인
        final startDate = controller.selectedDateRange.isNotEmpty
            ? controller.selectedDateRange
            .reduce((a, b) => a.isBefore(b) ? a : b)
            : null;
        final endDate = controller.selectedDateRange.isNotEmpty
            ? controller.selectedDateRange
            .reduce((a, b) => a.isAfter(b) ? a : b)
            : null;

        // 날짜 범위에 따른 UI 스타일 결정
        BoxDecoration? decoration;
        if (isSelected) {
          if (startDate == endDate) {
            // 단일 날짜 선택
            decoration = BoxDecoration(
              color: ColorBox.secondColor,
              shape: BoxShape.circle,
            );
          } else if (currentDate == startDate) {
            // 범위의 시작
            decoration = BoxDecoration(
              color: ColorBox.secondColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            );
          } else if (currentDate == endDate) {
            // 범위의 끝
            decoration = BoxDecoration(
              color: ColorBox.secondColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            );
          } else {
            // 범위 중간
            decoration = BoxDecoration(
              color: ColorBox.secondColor,
            );
          }
        }

        return Container(
          decoration: decoration,
          child: Center(
            child: Text(
              details.date.day.toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: isSelected
                    ? ColorBox.black
                    : (isCurrentMonth ? ColorBox.black : Colors.grey),
              ),
            ),
          ),
        );
      },
    ) : Container());
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
// class MeetingDataSource extends CalendarDataSource {
//   /// Creates a meeting data source, which used to set the appointment
//   /// collection to the calendar
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return _getMeetingData(index).from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return _getMeetingData(index).to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return _getMeetingData(index).eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return _getMeetingData(index).background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return _getMeetingData(index).isAllDay;
//   }
//
//   Meeting _getMeetingData(int index) {
//     final dynamic meeting = appointments![index];
//     late final Meeting meetingData;
//     if (meeting is Meeting) {
//       meetingData = meeting;
//     }
//
//     return meetingData;
//   }
// }
//
// /// Custom business object class which contains properties to hold the detailed
// /// information about the event data which will be rendered in calendar.
// class Meeting {
//   /// Creates a meeting class with required details.
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;
//
//   /// From which is equivalent to start time property of [Appointment].
//   DateTime from;
//
//   /// To which is equivalent to end time property of [Appointment].
//   DateTime to;
//
//   /// Background which is equivalent to color property of [Appointment].
//   Color background;
//
//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
//
//
// }
