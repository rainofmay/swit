import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/schedule/presentation/view/create_schedule_screen.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/calendar.dart';
import 'package:swit/features/study/schedule/presentation/widgets/schedule_list.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class ScheduleScreen extends GetView<ScheduleViewModel> {
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
      body: Padding(
        padding: const EdgeInsets.only(top:16.0),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: (details) {
                final double delta = details.primaryDelta ?? 0;
                if (delta > 0) {
                  controller.updateCalendarFormatToMonth();
                } else if (delta < 0) {
                  controller.updateCalendarFormatToWeek();
                }
              },
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: const Calendar()),
            ),
            const ScheduleList(),
          ],
        ),
      ),
    );
  }
}
