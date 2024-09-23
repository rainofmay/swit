import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/user/presentation/viewmodel/login_view_model.dart';
import 'package:swit/features/user/presentation/widget/auth_button.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class LoginScreen extends GetView<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorBox.secondColor,
      appBar: CustomBackAppBar(appbarTitle: '임시', isLeading: true, isCenterTitle: true),
      body: Column(
        children: [
          Text('Swit', style: FontBox.H4,),
          Text('같이 공부할래?', style: FontBox.B1,),

          const CustomGap(32),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              // 로고
              // child: Image.asset('name'),
            ),
          ),
          AuthButton(authName: '구글로 로그인', width: 280, height: 50, onPressed: () async {
            await controller.signInWithGoogle();
          }),
          const CustomGap(32),
          AuthButton(authName: '애플로 로그인', width: 280, height: 50, onPressed: () {}),
          const CustomGap(32),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          '© 2024 Swit. All rights reserved.',
          style: FontBox.B2.copyWith(color: ColorBox.grey),
        ),
      ),
    );
  }
}
