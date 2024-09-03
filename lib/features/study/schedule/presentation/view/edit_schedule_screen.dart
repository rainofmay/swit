import 'package:flutter/material.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';

class EditScheduleScreen extends StatelessWidget {
  const EditScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        appbarTitle: '',
        isLeading: true,
        isCenterTitle: true,
        actions: [TextButton(onPressed: () {
        }, child: Text('저장')),],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [],
      )),
    );
  }
}
