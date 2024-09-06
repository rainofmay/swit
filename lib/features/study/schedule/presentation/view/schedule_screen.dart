import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/schedule/presentation/view/create_schedule_screen.dart';
import 'package:swit/features/study/schedule/presentation/widgets/calendar.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
        appbarTitle: '우리 일정 만들기',
        isLeading: true,
        isCenterTitle: true,
        actions: [
          IconButton(
              onPressed: () {

                Get.toNamed(
                    Routes.STUDY + Routes.SCHEDULE + Routes.CREATESCHEDULE);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Calendar(),
    );
  }
}
