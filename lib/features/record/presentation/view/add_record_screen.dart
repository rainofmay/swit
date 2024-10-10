import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/features/record/presentation/widgets/task_list.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/infinity_horizon_line.dart';

class AddRecordScreen extends GetView<RecordViewModel> {
  const AddRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomBackAppBar(
        appbarTitle: '측 정',
        isLeading: true,
        isCenterTitle: true,
      ),
      body: Column(
        children: [
          const CustomGap(16),
          Obx(() => Text('오늘 총 공부 시간: ${controller.formattedTotalDailyStudyTime}')),
          // TimerWidget(),
          const CustomGap(16),
          InfinityHorizonLine(gap: 2, color: ColorBox.grey.shade200),
          TextButton(
              onPressed: () {
                controller.resetTaskForm();
                Get.toNamed(Routes.RECORD + Routes.RECORDADD + Routes.ADDTASK);
              },
              style: TextButton.styleFrom(
                foregroundColor: ColorBox.white, // 텍스트 색상
                backgroundColor: ColorBox.switchColor, // 배경 색상
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // 모서리 둥글기
                    side: BorderSide(color: ColorBox.switchColor, width: 1)),
              ),
              child: const Text('+ 측정할 새 과제 추가하기')),
          Expanded(child: TaskList()),
        ],
      ),
    );
  }
}