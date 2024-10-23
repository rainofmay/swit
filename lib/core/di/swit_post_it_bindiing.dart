import 'package:get/get.dart';
import 'package:swit/features/study/swit/data/datasources/study_group_reomote_data_source.dart';
import 'package:swit/features/study/swit/data/repsoitories/study_group_repository_impl.dart';
import 'package:swit/features/study/swit/domain/repositories/study_group_repository.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_post_it_view_model.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/swit_view_model.dart';
import 'package:swit/features/study/swit/domain/usecases/create_study_group_use_case.dart';
import 'package:swit/features/study/swit/domain/usecases/invite_to_group_use_case.dart';

class SwitPostItBindiing extends Bindings {
  @override
  void dependencies() {


    /* -- View Model -- */
    Get.lazyPut(() => SwitPostItViewModel());
  }
}