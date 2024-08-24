import 'package:get/get.dart';
import 'package:swit/features/home/presentations/viewmodel/bottombar_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarViewModel>(() => BottomBarViewModel());
  }
}