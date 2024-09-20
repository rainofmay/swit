import 'package:get/get.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';

class RecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecordViewModel());
  }
}