import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swit/core/utils/record/time_formatter.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  // freezed class에 메서드 추가 가능하게 하는 코드
  const Task._();


  const factory Task({
    required String id,
    required String title,
    required Color color,
    @Default(false) bool isDefault,
    @Default(0) int dailyStudyTime,
  }) = _Task;


  String getFormattedTaskTime() {
    return TimeFormatter.formatTime(dailyStudyTime);
  }

  bool isTitleValid() {
    return title.isNotEmpty && title.length <= 15;
  }
}
