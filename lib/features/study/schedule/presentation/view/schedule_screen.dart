import 'package:flutter/material.dart';
import 'package:swit/features/study/schedule/presentation/widgets/calendar.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(appbarTitle: '우리 일정 만들기', isLeading: true, isCenterTitle: true),
      body: Calendar(),
    );
  }
}