import 'package:get/get.dart';
import 'package:swit/domain/entities/home_tab_type.dart';

class BottomBarViewModel extends GetxController {
  late final Rx<HomeTab> _currentTab = HomeTab.home.obs;
  HomeTab get currentTab => _currentTab.value;


  /* update */
  void updateCurrentTab(HomeTab newTab) {
    _currentTab.value = newTab;
  }
}