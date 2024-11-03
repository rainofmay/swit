import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/record/presentation/widgets/study_log_card.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/features/record/presentation/widgets/record_calendar.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class RecordScreen extends GetView<RecordViewModel> {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => CustomScaffold(
        appBar: const CustomAppBar(appbarTitle: '기 록'),
        floatingActionButton: _conditionalFAB(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              // 캘린더 히트맵
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
                    child: const RecordCalendar()),
              ),
              const CustomGap(32),

              // 공부 일지
              Expanded(
                child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.selectedDateRecords.length,
                  itemBuilder: (context, index) {
                    final record = controller.selectedDateRecords[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: StudyLogCard(
                        id: record.id,
                        initialTitle: record.title,
                        initialContents: record.contents ?? '내용 없음',
                        initialStudyTime:
                        Duration(milliseconds: record.recordTime),
                        createdAt: DateTime.parse(record.date),
                      ),
                    );
                  },
                )),
              ),
            ],
          ),
        ),
      )),
    );
  }


  Widget? _conditionalFAB() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(
      controller.selectedDate.year,
      controller.selectedDate.month,
      controller.selectedDate.day,
    );

    if (selectedDate == today) {
      return FloatingActionButton.small(
        backgroundColor: ColorBox.white,
        onPressed: () {
          Get.toNamed(Routes.RECORD + Routes.ADDRECORD);
        },
        child: SvgPicture.asset(
          'assets/icons/log_plus_black.svg',
        ),
      );
    }
    return null;
  }
}
