import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/omni_date_time_picker_theme.dart';

Future<void> pickDate(
    {required BuildContext context, required bool isStartTime}) async {
  final vm = Get.find<ScheduleViewModel>();
  DateTime? pickerDate = await showOmniDateTimePicker(
    context: context,
    theme: OmniDateTimePickerTheme.theme,
    initialDate: isStartTime ? vm.editingSchedule.from : vm.editingSchedule.to,
    type: vm.editingSchedule.isAllDay
        ? OmniDateTimePickerType.date
        : OmniDateTimePickerType.dateAndTime,
    firstDate: DateTime.now().subtract(const Duration(days: 365 * 3)),
    lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
    is24HourMode: false,
    isShowSeconds: false,
    minutesInterval: 5,
    // secondsInterval: 1,
    isForce2Digits: true,
    borderRadius: const BorderRadius.all(Radius.circular(1)),
    constraints: const BoxConstraints(
      maxWidth: 350,
      maxHeight: 700,
    ),
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1.drive(
          Tween(
            begin: 0,
            end: 1,
          ),
        ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: true,
  );

  if (pickerDate != null) {
    if (isStartTime) {
      vm.updateScheduleFrom(pickerDate);
    } else {
      vm.updateScheduleTo(pickerDate);
    }
  } else {
    // 사용자가 선택을 취소한 경우, 기존 날짜를 유지
    // pickerDate = isStartTime
    //     ? viewModel.nowHandlingScheduleModel.startDate
    //     : viewModel.nowHandlingScheduleModel.endDate;
  }

  // viewModel.updateFormValidity();

}