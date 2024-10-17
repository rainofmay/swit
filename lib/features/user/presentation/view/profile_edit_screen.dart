import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_text_form_field.dart';
import 'package:swit/shared/widgets/profile_img.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class ProfileEditScreen extends GetView<UserViewModel> {
  ProfileEditScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
        appbarTitle: '프로필 편집',
        isLeading: true,
        isCenterTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              await _saveProfile();
            },
            child: const Text('저장'),
          ),
        ],
      ),
      body: Obx(() {
        _usernameController.text = controller.username;
        _introductionController.text = controller.introduction;

        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                const CustomGap(16),
                ProfileImg(
                  onTap: _showImageSourceDialog,
                  width: 90,
                  height: 90,
                  stackIcon: Icon(Icons.camera_enhance_rounded,
                    size: 18, color: ColorBox.grey,
                )),
                const CustomGap(32),
                _buildLabeledTextField('이 름', _usernameController, maxLength: 10),
                const CustomGap(40),
                _buildLabeledTextField('소 개', _introductionController, maxLength: 15),
                const CustomGap(16),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLabeledTextField(String label, TextEditingController controller, {int maxLength = 10}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 60, // 레이블의 고정 너비
          child: Text(label, style: FontBox.B1),
        ),
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            maxLength: maxLength,
            isReadOnly: false,
            isEnabled: true,
            inputBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorBox.grey.withOpacity(0.5)),
            ),
            textStyle: FontBox.B1,
            onChanged: (value) {
              // 필요한 경우 여기에 onChanged 로직
            },
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('프로필 사진 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('카메라로 촬영'),
              onTap: () {
                Get.back();
                controller.updateProfileImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('갤러리에서 선택'),
              onTap: () {
                Get.back();
                controller.updateProfileImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    try {
      final success = await controller.updateMyProfile(
        username: _usernameController.text,
        introduction: _introductionController.text,
      );
      if (success) {
         await controller.loadMyProfile();

      } else {
        Get.snackbar('오류', '프로필 업데이트에 실패했습니다.');
      }
    } catch (e) {
      Get.snackbar('오류', '프로필 업데이트 중 오류가 발생했습니다: $e');
    }
  }
}