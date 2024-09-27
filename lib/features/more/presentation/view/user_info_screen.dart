import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/more/presentation/view/delete_account_screen.dart';
import 'package:swit/features/user/presentation/viewmodel/login_view_model.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_row.dart';

class UserInfoScreen extends GetView<LoginViewModel> {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(appbarTitle: '내 정보 관리', isLeading: true, isCenterTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            TapRow(widget: Icon(CupertinoIcons.person_circle), title: '프로필 편집', onTap: (){}),
            const CustomGap(40),
            TapRow(widget: Icon(Icons.logout_rounded), title: '로그아웃', onTap: () async {
              Get.back();
              await controller.signOutWithGoogle();
            }),
            const CustomGap(40),
            TapRow(widget: Icon(Icons.phonelink_erase_rounded), title: 'Swit 탈퇴', onTap: (){
              Get.to(() => DeleteAccountScreen());
            }),
          ],
        ),
      ),
    );
  }
}
