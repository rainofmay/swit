import 'package:get/get.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/features/home/presentations/viewmodel/home_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
    MateBinding().dependencies(); //
  }
}