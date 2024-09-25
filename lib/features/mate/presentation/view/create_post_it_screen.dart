import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/mate/presentation/viewmodel/post_tab_view_model.dart';
import 'package:swit/features/mate/presentation/widgets/post_it.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class CreatePostItScreen extends GetView<PostTabViewModel> {
  const CreatePostItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScaffold(
      appBar: CustomBackAppBar(
        appbarTitle: '오늘 우리',
        isLeading: true,
        isCenterTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.checkmark_alt))
        ],
      ),
      body: Center(
          child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: ColorBox.secondColor,
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('user name'),
              Text(DateFormat('yyyy.MM.dd').format(controller.selectedDate)),
            ]),
            CustomGap(24),
            Obx(() => CustomTextFormField(
              isReadOnly: false,
              controller: controller.postItController,
              onChanged: (val) => controller.updatePostIt(),
              maxLength: 300,
            )),
          ],
        ),
      )),
    ));
  }
}
