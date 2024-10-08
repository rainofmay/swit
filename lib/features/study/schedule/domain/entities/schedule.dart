import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Schedule {
  String id;
  String scheduleName;
  String description;
  DateTime from;
  DateTime to;
  Color sectionColor;
  bool isAllDay;

  Schedule({
    required this.id,
    required this.scheduleName,
    required this.description,
    required this.from,
    required this.to,
    required this.sectionColor,
    required this.isAllDay,
  });

  bool isOnDay(DateTime day) {
    DateTime scheduleStart = DateTime(from.year, from.month, from.day);
    DateTime scheduleEnd = DateTime(to.year, to.month, to.day);
    DateTime dayStart = DateTime(day.year, day.month, day.day);

    return !scheduleEnd.isBefore(dayStart) && !scheduleStart.isAfter(dayStart);
  }

  String get formattedFromDate => DateFormat('yyyyMMdd').format(from);
  String get formattedToDate => DateFormat('yyyyMMdd').format(to);
}
