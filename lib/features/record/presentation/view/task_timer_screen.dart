import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
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
        // backFunction: _handleBackPress,
        backgroundColor: controller.recordingTask?.color ?? ColorBox.white,
        contentColor: controller.recordingTask!.color.computeLuminance() > 0.5 ? ColorBox.black : ColorBox.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _stopWatchDisplay(),
            const CustomGap(40),
            _controlButton(),
          ],
        ),
      ),
    );
  }

  Widget _stopWatchDisplay() {
    return Obx(() => Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorBox.primaryColor, width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.currentTaskTime.split('').map((char) {
          return Container(
            width: char == ':' ? 22 : 34, // 텍스트 간 간격
            alignment: Alignment.center,
            child: Text(
              char,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: ColorBox.switchColor,
              ),
            ),
          );
        }).toList(),
      ),
    ));
  }

  Widget _controlButton() {
    return Obx(() => ElevatedButton(
      onPressed: () {
        if (controller.isRunning) {
          _handleBackPress();
        } else {
          controller.startTaskStopWatch(controller.recordingTask!.id);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        controller.isRunning ? '정지' : '시작',
        style: FontBox.B1.copyWith(color: Colors.white),
      ),
    ));
  }

  void _handleBackPress() {
    if (controller.isRunning) {
      controller.pauseTaskStopWatch();
    }

    Get.back();
  }
}