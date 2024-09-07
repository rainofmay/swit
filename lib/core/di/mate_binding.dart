import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';

class MateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MateViewModel());
  }
}