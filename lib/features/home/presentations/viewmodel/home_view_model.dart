import 'package:get/get.dart';
import 'package:swit/app/enums/home_tab_type.dart';
import 'package:swit/core/di/home_binding.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/core/di/record_binding.dart';
import 'package:swit/core/di/setting_binding.dart';
import 'package:swit/core/di/user_binding.dart';

class HomeViewModel extends GetxController {
  final _currentTab = HomeTab.home.obs;
  HomeTab get currentTab => _currentTab.value;

  // 현재 활성화된 Binding을 추적
  List<Bindings> _currentBindings = [];

  void updateCurrentTab(HomeTab tab) {
    if (_currentTab.value != tab) {
      _disposeCurrentBinding();
      _currentTab.value = tab;
      _applyNewBinding(tab);
    }
  }

  void _disposeCurrentBinding() {
    switch (_currentTab.value) {
      case HomeTab.home:
        // (StudyBinding() as StudyBinding).dispose();
        break;
      case HomeTab.mate:
        (MateBinding()).dispose();
        break;
      case HomeTab.record:
        (RecordBinding()).dispose();
        break;
      case HomeTab.more:
        // (MoreBinding() as MoreBinding).dispose();
        break;
    }
    }

  void _applyNewBinding(HomeTab tab) {
    switch (tab) {
      case HomeTab.home:
        //HomeBindig은 main.dart에서 initialBinding에 넣어야 함.
        _currentBindings.add(SettingBinding());
        _currentBindings.add(UserBinding());
        break;
      case HomeTab.mate:
        _currentBindings.add(MateBinding());
        break;
      case HomeTab.record:
        _currentBindings.add(RecordBinding());
        break;
      case HomeTab.more:
        // _currentBinding = MoreBinding();
        break;
    }
    for (var binding in _currentBindings) {
      binding.dependencies();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // 초기 탭에 대한 바인딩 적용
    _applyNewBinding(_currentTab.value);
  }

  @override
  void onClose() {
    _disposeCurrentBinding();
    super.onClose();
  }
}