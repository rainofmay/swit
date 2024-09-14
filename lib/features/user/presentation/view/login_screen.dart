import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/user/presentation/viewmodel/login_view_model.dart';
import 'package:swit/features/user/presentation/widget/auth_button.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class LoginScreen extends GetView<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorBox.secondColor,
      body: Column(
        children: [
          Text('Swit', style: FontBox.TITLESTYLE,),
          Text('같이 공부할래?', style: FontBox.CONTENTSTYLE,),
          Text('Copyright', style: FontBox.MINISTYLE,),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              // 로고
              // child: Image.asset('name'),
            ),
          ),
          AuthButton(width: 500, height: 300, onPressed: () async {
            await controller.signInWithGoogle();
          })
        ],
      ),
    );
  }
}
