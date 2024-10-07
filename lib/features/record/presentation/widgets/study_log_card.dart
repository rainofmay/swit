import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/ok_cancel._buttons.dart';

class StudyLogCard extends GetView<RecordViewModel> {
  final String id;
  final String initialTitle;
  final String initialContent;
  final Duration initialStudyTime;
  final DateTime createdAt;

  const StudyLogCard({
    super.key,
    required this.id,
    required this.initialTitle,
    required this.initialContent,
    required this.initialStudyTime,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    controller.contentsController.text = initialContent;

    return Obx(() => GestureDetector(
          onTap: controller.toggleEditing,
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: ColorBox.white,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: ColorBox.primaryColor, width: 4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.isEditing) ...[
                      Text('과제 : $initialTitle',
                          style: FontBox.H5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const CustomGap(16),
                      TextField(
                        controller: controller.contentsController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: '내용 ',
                          hintText: '공부한 내용을 입력해 보세요',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              initialTitle,
                              style: FontBox.H5,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(CupertinoIcons.clock,
                                  size: IconSize.xs, color: ColorBox.black),
                              const CustomGap(4),
                              Text(
                                _formatDuration(initialStudyTime),
                                style: FontBox.B2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const CustomGap(8),
                      Text(
                        controller.contentsController.text,
                        style: FontBox.B1,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const CustomGap(12),
                    if (controller.isEditing)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => controller.updateRecord(
                                id, controller.contentsController.text),
                            child: Text('수정'),
                          ),
                          TextButton(
                            onPressed: () {
                              customDialog(
                                  context,
                                  50,
                                  '공부 기록을 삭제하시겠습니까?',
                                  Text('복구할 수 없습니다.', style: FontBox.B1,),
                                  OkCancelButtons(
                                      okText: '삭제',
                                      onPressed: () async =>
                                          controller.deleteRecord(id),
                                      cancelText: '취소',
                                      onCancelPressed: () => Get.back()));
                            },
                            child: Text('삭제'),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}시간 ${minutes}분';
  }
}
