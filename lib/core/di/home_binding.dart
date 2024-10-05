import 'package:get/get.dart';
import 'package:swit/features/home/presentations/viewmodel/home_view_model.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());

  }
}