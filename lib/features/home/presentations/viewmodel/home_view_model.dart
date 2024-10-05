import 'package:get/get.dart';
import 'package:swit/app/enums/home_tab_type.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/core/di/record_binding.dart';

class HomeViewModel extends GetxController {
  final _currentTab = HomeTab.home.obs;
  HomeTab get currentTab => _currentTab.value;

  // 현재 활성화된 Binding을 추적
  Bindings? _currentBinding;

  void updateCurrentTab(HomeTab tab) {
    if (_currentTab.value != tab) {
      _disposeCurrentBinding();
      _currentTab.value = tab;
      _applyNewBinding(tab);
    }
  }

  void _disposeCurrentBinding() {
    if (_currentBinding != null) {
      switch (_currentTab.value) {
        case HomeTab.home:
          // (StudyBinding() as StudyBinding).dispose();
          break;
        case HomeTab.mate:
          (MateBinding() as MateBinding).dispose();
          break;
        case HomeTab.record:
          (RecordBinding() as RecordBinding).dispose();
          break;
        case HomeTab.more:
          // (MoreBinding() as MoreBinding).dispose();
          break;
      }
      _currentBinding = null;
    }
  }

  void _applyNewBinding(HomeTab tab) {
    switch (tab) {
      case HomeTab.home:
        // _currentBinding = StudyBinding();
        break;
      case HomeTab.mate:
        _currentBinding = MateBinding();
        break;
      case HomeTab.record:
        _currentBinding = RecordBinding();
        break;
      case HomeTab.more:
        // _currentBinding = MoreBinding();
        break;
    }
    _currentBinding?.dependencies();
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