import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/mate/presentation/viewmodel/post_tab_view_model.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class PostItNote extends GetView<PostTabViewModel> {
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
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          // Content
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Header (작성자, 날짜)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'User Name', // 실제 사용자 이름으로 교체 필요
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Obx(() => Text(
                      DateFormat('yyyy.MM.dd').format(controller.selectedDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    )),
                  ],
                ),
                const CustomGap(16),
                // 내용 영역 (편집 모드에 따라 다르게 표시)
                Expanded(
                  child: CustomTextFormField(
                    isReadOnly: false,
                    controller: controller.postItController,
                    onChanged: (val) => controller.updatePostIt(),
                    maxLength: 300,
                    // decoration: const InputDecoration(
                    //   border: InputBorder.none,
                    //   hintText: '마음을 담아 메시지를 작성해보세요...',
                    //   hintStyle: TextStyle(
                    //     color: Colors.black38,
                    //     fontSize: 14,
                    //   ),
                    //   counterStyle: TextStyle(
                    //     color: Colors.black54,
                    //     fontSize: 12,
                    //   ),
                    // ),

                    maxLines: null,
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
