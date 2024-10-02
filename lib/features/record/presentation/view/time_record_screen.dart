import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class TimeRecordScreen extends GetView<RecordViewModel> {
  const TimeRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorBox.white,
      appBar: CustomBackAppBar(appbarTitle: '기록 추가', isLeading: true, isCenterTitle: true),
    );
  }
}
