import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swit/features/mate/presentation/widgets/post_it.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class CreatePostItScreen extends StatelessWidget {
  const CreatePostItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScaffold(
      appBar: CustomBackAppBar(
        appbarTitle: '오늘 우리',
        isLeading: true,
        isCenterTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.checkmark_alt))],
      ),
      body: Center(child: PostIt()),
    ));
  }
}
