import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class TaskTimerScreen extends GetView<RecordViewModel> {
  const TaskTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
        appbarTitle: controller.recordingTask?.title ?? '',
        isLeading: true,
        isCenterTitle: true,
        backFunction: _handleBackPress,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimerDisplay(),
            SizedBox(height: 40),
            _buildControlButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerDisplay() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: controller.recordingTask?.color.withOpacity(0.1) ?? Colors.grey.withOpacity(0.1),
      ),
      child: Obx(() => Text(
        controller.currentTaskTime,
        style: FontBox.H1.copyWith(
          color: controller.recordingTask?.color ?? Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }

  Widget _buildControlButton() {
    return Obx(() => ElevatedButton(
      onPressed: () {
        if (controller.isRunning) {
          _handleBackPress();
        } else {
          controller.startTaskTimer(controller.recordingTask!.id);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        controller.isRunning ? '정지' : '시작',
        style: FontBox.B1.copyWith(color: Colors.white),
      ),
    ));
  }

  void _handleBackPress() {
    Get.back();
    if (controller.isRunning) {
      controller.pauseTaskTimer();
    }
  }
}