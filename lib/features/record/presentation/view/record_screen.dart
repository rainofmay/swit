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
        child: CustomScaffold(
          appBar: const CustomAppBar(appbarTitle: '기 록'),
          floatingActionButton: FloatingActionButton.small(
            backgroundColor: ColorBox.white,
              onPressed: () {
                Get.toNamed(Routes.RECORD + Routes.RECORDADD);
              },
              child: SvgPicture.asset(
                'assets/icons/log_black.svg',
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                RecordCalendar(),
                const CustomGap(32),
                Expanded(
                  child: Obx(() => ListView.builder(
                    itemCount: controller.records.length,
                    itemBuilder: (context, index) {
                      final record = controller.records[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: StudyLogCard(
                          initialContent: record.contents ?? '내용 없음',
                          initialStudyTime: Duration(milliseconds: record.recordTime),
                          createdAt: DateTime.parse(record.date),
                          onSave: (content, studyTime) {
                            // TODO: 저장 로직 구현
                            print('Content: $content');
                            print('Study Time: $studyTime');
                          },
                        ),
                      );
                    },
                  )),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
