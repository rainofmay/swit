import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/features/record/presentation/widgets/task_list_widget.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/features/record/presentation/widgets/timer_widget.dart';

class AddRecordScreen extends GetView<RecordViewModel> {
  const AddRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomBackAppBar(
        appbarTitle: '측 정',
        isLeading: true,
        isCenterTitle: true,
      ),
      body: Column(
        children: [
          const CustomGap(16),
          TimerWidget(),
          const CustomGap(16),
          Expanded(child: TaskListWidget(controller : controller)),
        ],
      ),
    );
  }
}