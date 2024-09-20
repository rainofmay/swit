import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swit/core/enums/bg_theme.dart';
import 'dart:io' as io;

import 'package:swit/features/study/swit/presentation/viewmodel/bg_setting_view_model.dart';

class BuildBackground extends StatelessWidget {
  final vm = Get.find<BgSettingViewModel>();
  BuildBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Obx(() {
          switch (vm.editingTheme) {
            case BgTheme.day:
              return Image.asset(vm.bgThemeMap[BgTheme.day]!, fit: BoxFit.cover);
            case BgTheme.night:
              return Image.asset(vm.bgThemeMap[BgTheme.night]!, fit: BoxFit.cover);
            case BgTheme.custom:
              return _customImage(context);
          }
        }),
      ),
    );
  }


  Widget _customImage(BuildContext context) {
    String customImagePath = vm.bgThemeMap[BgTheme.custom] ?? '';

    if (customImagePath.isNotEmpty) {
      return Image.file(
        io.File(customImagePath),
        fit: BoxFit.cover,
      );
    } else {
      return _buildImagePickerButton(context);
    }
  }

  Widget _buildImagePickerButton(BuildContext context) {
    return InkWell(
      onTap: () => _pickImage(context),
      child: Container(
        color: Colors.grey[200],
        child: Center(
          child: Icon(
            Icons.add_photo_alternate,
            size: 50,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      vm.updateCustomImagePath(image.path);
    }
  }
}


