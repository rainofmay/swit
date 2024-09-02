import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/schedule_service.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends GetView<ScheduleViewModel> {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
        view: CalendarView.month,
        dataSource: controller.scheduleService,

        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showAgenda: true, // 하단에 이벤트 내용 표시
          agendaStyle: AgendaStyle(),
        ),
        onSelectionChanged: null,
        // 년, 월 헤더 스타일
        headerStyle: CalendarHeaderStyle(backgroundColor: ColorBox.white, textStyle: FontBox.CONTENTSTYLE.copyWith(color: ColorBox.primaryColor)),
        // 요일 헤더 스타일
        viewHeaderStyle: ViewHeaderStyle(backgroundColor: ColorBox.secondColor),
        showDatePickerButton : true,
      onTap: controller.onTap,
      onLongPress: controller.onLongPress,
      monthCellBuilder: (context, details) {
        final currentDate = DateTime(details.date.year, details.date.month, details.date.day);
        final isSelected = controller.selectedDateRange.contains(currentDate);

        // 선택된 범위의 시작과 끝 날짜 확인
        final startDate = controller.selectedDateRange.isNotEmpty
            ? controller.selectedDateRange.reduce((a, b) => a.isBefore(b) ? a : b)
            : null;
        final endDate = controller.selectedDateRange.isNotEmpty
            ? controller.selectedDateRange.reduce((a, b) => a.isAfter(b) ? a : b)
            : null;

        // 날짜 범위에 따른 UI 스타일 결정
        BoxDecoration? decoration;
        if (isSelected) {
          if (startDate == endDate) {
            // 단일 날짜 선택
            decoration = BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              shape: BoxShape.circle,
            );
          } else if (currentDate == startDate) {
            // 범위의 시작
            decoration = BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            );
          } else if (currentDate == endDate) {
            // 범위의 끝
            decoration = BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            );
          } else {
            // 범위 중간
            decoration = BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
            );
          }
        }

        return Container(
          decoration: decoration,
          child: Center(
            child: Text(
              details.date.day.toString(),
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      },
    );
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