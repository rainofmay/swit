import 'package:get/get.dart';



class SwitSettingViewModel extends GetxController {
  late final RxBool _isTimer = false.obs;
  bool get isTimer => _isTimer.value;

  /* -- update -- */
  void toggleIsTimer(bool newValue) {
    _isTimer.value = newValue;
    print(_isTimer.value);
  }
}