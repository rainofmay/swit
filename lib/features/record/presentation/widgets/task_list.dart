import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/presentation/view/task_timer_screen.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';

class TaskList extends GetView<RecordViewModel> {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _showTaskOptions(context, task),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: task.color,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(task.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: FontBox.H5.copyWith(
                                      color:
                                          task.color.computeLuminance() >
                                                  0.5
                                              ? ColorBox.black
                                              : ColorBox.white))),
                          Obx(() => Text(
                              controller.getFormattedTaskTime(task.id),
                              style: FontBox.B2.copyWith(
                                  color:
                                      task.color.computeLuminance() > 0.5
                                          ? ColorBox.black
                                          : ColorBox.white)))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showTaskOptions(BuildContext context, Task task) {
    if (controller.isRunning &&
        controller.recordingTask != null &&
        controller.recordingTask!.id != task.id) {
      // 현재 측정 중인 과제가 있고, 선택한 과제가 현재 측정 중인 과제가 아닐 경우
      customDialog(
        context,
        100,
        '경고',
        Text('${controller.recordingTask!.title} 과제를 먼저 종료한 뒤, 다시 시도해 주세요.'),
        TextButton(
          child: Text('확인', style: FontBox.B1),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
    } else {
      customDialog(
        context,
        150,
        task.title,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: const Text('공부 시간 측정하기', style: FontBox.B1),
              onPressed: () {
                controller.updateRecordingTask(task);
                Get.back(); // 다이얼로그 닫기
                Get.to(() => TaskTimerScreen());
              },
            ),
            TextButton(
              child: const Text('과제 수정', style: FontBox.B1),
              onPressed: () {
                Get.back(); // 다이얼로그 닫기
                controller.updateEditingTask(task);
                Get.toNamed(Routes.RECORD + Routes.ADDRECORD + Routes.EDITTASK);
              },
            ),
            TextButton(
              child: const Text('과제 삭제', style: FontBox.B1),
              onPressed: () {
                Get.back(); // 다이얼로그 닫기
                controller.deleteTask(task);
              },
            ),
          ],
        ),
        null,
      );
    }
  }
}
