import 'package:get/get.dart';
import 'package:swit/core/utils/schedule_service.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/features/study/setting/presentation/viewmodel/bg_setting_view_model.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScheduleViewModel());
  }
}