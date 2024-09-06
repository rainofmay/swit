import 'package:flutter/material.dart';

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
}
