import 'package:flutter/material.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomBackAppBar(appbarTitle: '프로필 편집', isLeading: true, isCenterTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //프로필 사진
            const CustomGap(16),
            // 팔로우 정보
            const CustomGap(16),
            // 아이디, 소개
          ],
        ),
      ),
    );
  }
}
