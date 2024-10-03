import 'package:flutter/material.dart';

class Task {
  final String id;
  String title;
  Color color;
  final bool isDefault;
  int dailyStudyTime; // in milliseconds

  Task({
    required this.id,
    required this.title,
    required this.color,
    this.isDefault = false,
    this.dailyStudyTime = 0,
  });

  Task copyWith({
    String? id,
    String? title,
    Color? color,
    bool? isDefault,
    int? dailyStudyTime,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
      dailyStudyTime: dailyStudyTime ?? this.dailyStudyTime,
    );
  }
}
