import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordViewModel extends GetxController {
  /* Tab */
  late final RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;

  /* Calendar */
  late final Rx<DateTime> _selectedDate;
  DateTime get selectedDate => _selectedDate.value;
  late final Rx<DateTime> _focusedDate;
  DateTime get focusedDate => _focusedDate.value;

  late final Rx<CalendarFormat> _calendarFormat;
  CalendarFormat get calendarFormat => _calendarFormat.value;


  /* -- update -- */
  void updateTapIndex(int newIndex) {
    _tabIndex.value = newIndex;
  }

}