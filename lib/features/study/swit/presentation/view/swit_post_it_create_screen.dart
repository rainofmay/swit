import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_post_it_view_model.dart';
import 'package:swit/features/study/swit/presentation/widgets/post_it_note.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class SwitPostItCreateScreen extends GetView<SwitPostItViewModel> {
  const SwitPostItCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        appBar: CustomBackAppBar(
          appbarTitle: '쪽지 쓰기',
          isLeading: true,
          isCenterTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.checkmark_alt))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const CustomGap(24),
                // PostItNote 위젯 사용
                Center(
                  child: PostItNote(),
                ),
                const CustomGap(24),
                // 날짜 선택기
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '날짜 선택',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const CustomGap(8),
                      InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: controller.selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            controller.updateSelectedDate(picked);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                              DateFormat('yyyy년 MM월 dd일')
                                  .format(controller.selectedDate),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            )),
                            const Icon(
                              Icons.calendar_today,
                              size: 20,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}