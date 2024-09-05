import 'package:flutter/material.dart';

class Schedule {
   String scheduleName;
   String? description;
   DateTime from;
   DateTime to;
   Color sectionColor;
   bool isTimeSet;

   Schedule({
    required this.scheduleName,
    this.description,
    required this.from,
    required this.to,
    required this.sectionColor,
    required this.isTimeSet,
  });
}
