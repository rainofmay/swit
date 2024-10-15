import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swit/features/mate/presentation/widgets/profile_img.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class ProfileEditScreen extends GetView<UserViewModel> {
  ProfileEditScreen({super.key}) {
    _usernameController.text = controller.user?.username ?? '';
    _introductionController.text = controller.user?.introduction ?? '';
  }

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
            onPressed: _saveProfile,
            child: const Text('저장'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CustomGap(16),
              ProfileImg(
                onTap: _showImageSourceDialog,
                width: 90,
                height: 90,
              ),
              const CustomGap(16),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: '사용자 이름'),
              ),
              const CustomGap(16),
              TextField(
                controller: _introductionController,
                decoration: const InputDecoration(labelText: '소개'),
                maxLines: 3,
              ),
              const CustomGap(16),
            ],
          ),
        ),
      ),
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
                _getImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('갤러리에서 선택'),
              onTap: () {
                Get.back();
                _getImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      try {
        await controller.updateMyProfile(profileUrl: image.path);
        Get.snackbar('성공', '프로필 이미지가 업데이트되었습니다.');
      } catch (e) {
        Get.snackbar('오류', '이미지 업로드에 실패했습니다.');
      }
    }
  }

  Future<void> _saveProfile() async {
    await controller.updateMyProfile(
      username: _usernameController.text,
      introduction: _introductionController.text,
    );
    Get.back();
  }
}
