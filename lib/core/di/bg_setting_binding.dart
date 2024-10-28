import 'package:get/get.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/bg_setting_view_model.dart';

class BgSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BgSettingViewModel(), permanent: true);
  }
}