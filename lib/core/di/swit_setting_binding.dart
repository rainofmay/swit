import 'package:get/get.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_setting_view_model.dart';

class SwitSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SwitSettingViewModel());
  }
}