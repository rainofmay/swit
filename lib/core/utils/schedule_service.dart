import 'package:flutter/material.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/* 캘린더 View 단에서 활용하기 위한 Service Class */

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
    return getScheduleData(index).sectionColor;
  }

  @override
  bool isAllDay(int index) {
    return getScheduleData(index).isTimeSet;
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
