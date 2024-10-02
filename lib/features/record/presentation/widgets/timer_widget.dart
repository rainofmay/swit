import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class TimerWidget extends GetView<RecordViewModel> {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ColorBox.secondColor,
            ),
            child: Column(
              children: [
                _studyTimeDisplay(),
                const CustomGap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Obx(() => ElevatedButton(
                      onPressed: () {
                        controller.toggleTimer();

                        if (controller.isRunning == false) {
                          Get.toNamed(Routes.RECORD + Routes.RECORDADD + Routes.TIMERECORD);
                        }
                      },
                      child: Text(controller.isRunning ? '일시 정지' : '바로 시작'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isRunning ? Colors.orange : Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    )),
                    const CustomGap(16),
                    ElevatedButton(
                      onPressed: controller.resetTimer,
                      child: Text('리셋'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    const CustomGap(16),
                    ElevatedButton(
                      onPressed: controller.recordTime,
                      child: Text('기록'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text('오늘 공부한 시간'),
          SizedBox(height: 20),
          Text('기록된 시간:'),
          Container(
            height: 100,
            child: Obx(() => ListView.builder(
              itemCount: controller.records.length,
              itemBuilder: (context, index) {
                return Text(controller.formatTime(controller.records[index]));
              },
            )),
          ),
          Obx(() => Text('합계: ${controller.formatTime(controller.sum)}')),
        ],
      ),
    );
  }


  Widget _studyTimeDisplay() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: controller.result.split('').map((char) {
        return Container(
          width: char == ':' ? 22 : 38,
          alignment: Alignment.center,
          child: Text(
            char,
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: ColorBox.switchColor,
            ),
          ),
        );
      }).toList(),
    ));
  }
}