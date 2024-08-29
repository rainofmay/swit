import 'package:get/get.dart';
import 'package:swit/features/study/setting/presentation/viewmodel/bg_setting_view_model.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BgSettingViewModel(), permanent: true);
  }
}