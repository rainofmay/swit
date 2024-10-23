import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_post_it_view_model.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class PostItNote extends GetView<SwitPostItViewModel> {
  const PostItNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 340,
      child: Stack(
        children: [
          // Post-it background
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/post_it.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          // Content
          Container(
            padding: const EdgeInsets.only(top: 50, left: 24.0, right: 24, bottom: 24),
            child: Column(
              children: [

                // 내용 영역 (편집 모드에 따라 다르게 표시)
                Expanded(
                  child: CustomTextFormField(
                    isReadOnly: false,
                    controller: controller.postItController,
                    onChanged: (val) => controller.updatePostIt(),
                    maxLength: 240,
                    textStyle: FontBox.B1.copyWith(height: 1.5),
                    inputBorder: InputBorder.none,
                    autofocus: true,
                    maxLines: null,
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'User Name', // 실제 사용자 이름으로 교체 필요
                      style: FontBox.B2.copyWith(fontWeight: FontWeight.bold)
                    ),
                    const CustomGap(16),
                    Obx(() => Text(
                      DateFormat('yyyy.MM.dd').format(controller.selectedDate),
                      style: FontBox.B3,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
