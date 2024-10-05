import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/schedule/presentation/widgets/omni_date_time_picker_theme.dart';

Future<void> pickMonthYear(
    {required BuildContext context, required dynamic vm}) async {
  DateTime? pickerDate = await showOmniDateTimePicker(
    context: context,
    theme: OmniDateTimePickerTheme.theme,
    initialDate: vm.selectedDate,
    type: OmniDateTimePickerType.date,
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

  // 사용자가 날짜를 선택했을 경우 ViewModel 업데이트
  if (pickerDate != null) {
    // 선택된 날짜의 년도와 월만 사용하여 새 DateTime 객체 생성
    DateTime selectedMonthYear = DateTime(pickerDate.year, pickerDate.month, pickerDate.day);

    // ViewModel의 selectedDate 업데이트
    vm.updateSelectedDate(selectedMonthYear);
    vm.updateFocusedDate(selectedMonthYear);
  }
}