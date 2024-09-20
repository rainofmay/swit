import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/features/mate/presentation/widgets/calendar.dart';

class StudyRecordScreen extends GetView<RecordViewModel> {
  const StudyRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('공부 기록'),
      ],
    );
  }
}
