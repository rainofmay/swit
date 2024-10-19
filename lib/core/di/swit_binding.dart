import 'package:get/get.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_view_model.dart';

class SwitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SwitViewModel());
  }
}