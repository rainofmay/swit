import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/schedule_form.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class CreateScheduleScreen extends GetView<ScheduleViewModel> {
  const CreateScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
        appbarTitle: '',
        isLeading: true,
        isCenterTitle: true,
        actions: [
          TextButton(
                onPressed: () {

                  // viewModel.isFormValid ? _onSavePressed(context) : null;
                },
                child: Text(
                  '저장',
                  style: TextStyle(
                      // color: viewModel.isFormValid ? ColorBox.primaryColor : ColorBox.grey
                  ),
                ),
              )
        ],
      ),
      body: ScheduleForm()
    );
  }
}
