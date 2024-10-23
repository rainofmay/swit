import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/study/swit/presentation/widgets/post_it_calendar.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';

class SwitPostItScreen extends StatelessWidget {
  const SwitPostItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
          appbarTitle: 'Swit 쪽지', isLeading: true, isCenterTitle: true, actions: [
            IconButton(onPressed: () {
              Get.toNamed(Routes.STUDY + Routes.SWIT + Routes.SWITPOST + Routes.SWITCREATEPOST);
            }, icon: Icon(Icons.add))
      ],),
      body: Column(
        children: [
          PostItCalendar(),
          Text('캐러셀')],
      ),
    );
  }
}
