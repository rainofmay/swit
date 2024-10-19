import 'package:flutter/material.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(appbarTitle: '알림', isLeading: true, isCenterTitle: true),
      body: Column(children: [
        Text('알림 화면')
      ],),
    );
  }
}
