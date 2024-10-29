import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/more/presentation/view/delete_account_screen.dart';
import 'package:swit/features/user/presentation/viewmodel/login_view_model.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_row.dart';

class UserInfoScreen extends GetView<LoginViewModel> {
  UserInfoScreen({super.key});

  final UserViewModel userVM = Get.find<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomBackAppBar(appbarTitle: '내 정보 관리', isLeading: true, isCenterTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            TapRow(widget: Icon(CupertinoIcons.person_circle), title: '프로필 편집', onTap: (){
              Get.toNamed(Routes.EDITPROFILE);
            }),
            const CustomGap(40),
            TapRow(widget: Icon(Icons.logout_rounded), title: '로그아웃', onTap: () async {
              await controller.signOutWithGoogle();
              userVM.clearUserData();
              Get.back();
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
