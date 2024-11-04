import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_view_model.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class SwitGroupContainer extends GetView<SwitViewModel> {
  const SwitGroupContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // 그룹원 프로필 사진들 추가. D-day, 문구.
      children: [
        SizedBox(
            width: 160,
            height: 160,
            child: Image.asset('assets/images/logo.png')),
        const CustomGap(32),
        Text(DateFormat('yyyy-MM-dd').format(DateTime.now())),
      ],
    );
  }
}
