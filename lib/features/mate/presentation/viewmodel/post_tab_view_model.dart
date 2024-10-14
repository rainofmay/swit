import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class PostTabViewModel extends GetxController {
  final MateViewModel _mateViewModel;

  PostTabViewModel({required MateViewModel mateViewModel}) : _mateViewModel = mateViewModel ;


  late final Rx<TextEditingController> _postItController = TextEditingController().obs;
  TextEditingController get postItController => _postItController.value;
  late final RxString _postIt = ''.obs;
  String get postIt => _postIt.value;

  /* -- Calendar -- */
 final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
 final Rx<DateTime> _focusedDate = DateTime.now().obs;
  DateTime get focusedDate => _focusedDate.value;

  final Rx<CalendarFormat> _calendarFormat = CalendarFormat.month.obs;
  CalendarFormat get calendarFormat => _calendarFormat.value;


  @override
  void onInit() {
    super.onInit();
    _postItController.value.addListener(updatePostIt);
  }

  @override
  void onClose() {

    super.onClose();
  }

  void updateSelectedDate(DateTime selectedDate) {
    _selectedDate.value = selectedDate;
  }

  void updateFocusedDate(DateTime focusedDate) {
    _focusedDate.value = focusedDate;
  }

  void updatePostIt() {
    _postIt.value = _postItController.value.text;
  }
}