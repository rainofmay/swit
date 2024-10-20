import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_check_box.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';

class CreateSwitScreen extends GetView<SwitViewModel> {
  final MateViewModel _mateVM = Get.find<MateViewModel>();

  CreateSwitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
          appbarTitle: '스터디 생성',
          isLeading: true,
          isCenterTitle: true,
          actions: [
            Obx(() {
              final isEnabled = controller.selectedUsers.isNotEmpty;
              return TextButton(
                  onPressed: isEnabled ? _createGroup : null,
                  child: Text('초대',
                      style: isEnabled
                          ? FontBox.activtedActions
                          : FontBox.disabledActions));
            })
          ]),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: _mateVM.followingList.length,
                    itemBuilder: (context, index) {
                      User user = _mateVM.followingList[index];
                      return ListTile(
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: user.profileUrl.isEmpty
                                ? Image.asset(
                                    'assets/images/basic_profile.jpg',
                                    fit: BoxFit.cover,
                                    width: 32,
                                    height: 32,
                                  )
                                : Image.network(user.profileUrl)),
                        title: Text(user.username ?? '', style: FontBox.B2),
                        trailing: Obx(() => CustomCheckBox(
                              value:
                                  controller.selectedUsers.contains(user.uid),
                              onChanged: (_) =>
                                  controller.toggleUserSelection(user.uid),
                              radius: 50,
                              activeColor: ColorBox.primaryColor,
                              checkColor: ColorBox.white,
                              borderColor: ColorBox.grey.shade100,
                            )),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _createGroup() async {
    bool success = await controller.createGroup();
    if (success) {
      controller.resetGroupCreation();
      Get.back(); // 생성 성공 시 이전 화면으로 돌아갑니다.
    }
  }
}
