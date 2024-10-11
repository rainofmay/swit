import 'package:get/get.dart';

class SwitSettingViewModel extends GetxController {
  final RxMap<String, bool> _toggleStates = <String, bool>{}.obs;

  bool getToggleState(String key) => _toggleStates[key] ?? false;

  @override
  void onInit() {
    super.onInit();
    _toggleStates.addAll({
      'timer': false,
      'dday': false,
      'phrase': false,
      'notification': false,
    });
  }

  void toggleState(String key) {
    _toggleStates[key] = !(_toggleStates[key] ?? false);
  }

}