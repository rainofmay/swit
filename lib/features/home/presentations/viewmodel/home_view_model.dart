import 'package:get/get.dart';
import 'package:swit/app/enums/home_tab_type.dart';
import 'package:swit/core/di/home_binding.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/core/di/record_binding.dart';
import 'package:swit/core/di/setting_binding.dart';
import 'package:swit/core/di/user_binding.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';

class HomeViewModel extends GetxController {
  final _currentTab = HomeTab.home.obs;
  HomeTab get currentTab => _currentTab.value;
  final List<Bindings> _currentBindings = [];

  void updateCurrentTab(HomeTab tab) {
    if (_currentTab.value != tab) {
      _ensureBinding(tab);  // 바인딩 확인 후 탭 변경
      _currentTab.value = tab;
    }
  }

  void _ensureBinding(HomeTab tab) {
    _currentBindings.clear();

    switch (tab) {
      case HomeTab.home:
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
        break;
    }

    for (var binding in _currentBindings) {
      binding.dependencies();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _ensureBinding(_currentTab.value);
  }
}
