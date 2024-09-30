import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/infinity_horizon_line.dart';
import 'package:swit/shared/widgets/infinity_vertical_line.dart';

class TaskListWidget extends StatelessWidget {
  final RecordViewModel controller;

  const TaskListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfinityHorizonLine(
          gap: 2,
          color: ColorBox.grey.shade200,
        ),
        TextButton(onPressed: () {
          Get.toNamed(Routes.RECORD + Routes.RECORDADD + Routes.HANDLETASK);
        },
            style: TextButton.styleFrom(
              foregroundColor: ColorBox.white, // 텍스트 색상
              backgroundColor: ColorBox.switchColor, // 배경 색상
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 패딩
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // 모서리 둥글기
                side: BorderSide(color: ColorBox.switchColor, width: 1), // 테두리
              ),
            ),
            child: const Text('+ 측정할 새 과제 추가하기')),
        Expanded(
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.tasks.length,
              itemBuilder: (context, index) {
                final task = controller.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => controller.deleteTask(task),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
