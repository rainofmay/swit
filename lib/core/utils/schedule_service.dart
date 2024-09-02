import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/* 캘린더 UI로 변환을 위한 Service Class */

class ScheduleService extends CalendarDataSource {
  ScheduleService(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return getScheduleData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return getScheduleData(index).to;
  }

  @override
  String getSubject(int index) {
    return getScheduleData(index).scheduleName;
  }

  @override
  Color getColor(int index) {
    return getScheduleData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return getScheduleData(index).isAllDay;
  }

  Schedule getScheduleData(int index) {
    final dynamic schedule = appointments![index];
    late final Schedule scheduleData;
    if (schedule is Schedule) {
      scheduleData = schedule;
    }

    return scheduleData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Schedule {
  /// Creates a meeting class with required details.
  Schedule(this.scheduleName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String scheduleName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;


}