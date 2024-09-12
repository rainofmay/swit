import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class LoginScreen extends StatelessWidget {
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
        ],
      ),
    );
  }
}
