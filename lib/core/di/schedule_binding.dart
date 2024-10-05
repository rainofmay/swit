import 'package:get/get.dart';
import 'package:swit/features/study/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:swit/features/study/schedule/data/repsoitories/schedule_repository_impl.dart';
import 'package:swit/features/study/schedule/domain/repositories/schedule_repository.dart';
import 'package:swit/features/study/schedule/domain/usecases/create_schedule_use_case.dart';
import 'package:swit/features/study/schedule/domain/usecases/delete_schedule_use_case.dart';
import 'package:swit/features/study/schedule/domain/usecases/get_schedule_use_case.dart';
import 'package:swit/features/study/schedule/domain/usecases/update_schedule_use_case.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    /* -- DataSource -- */
    Get.put<ScheduleRemoteDataSource>(ScheduleRemoteDataSource());

    /* -- Repository -- */
    Get.put<ScheduleRepository>(
      ScheduleRepositoryImpl(Get.find<ScheduleRemoteDataSource>()),
    );

    /* -- UseCase -- */
    Get.put(GetScheduleUseCase(Get.find<ScheduleRepository>()));
    Get.put(CreateScheduleUseCase(Get.find<ScheduleRepository>()));
    Get.put(UpdateScheduleUseCase(Get.find<ScheduleRepository>()));
    Get.put(DeleteScheduleUseCase(Get.find<ScheduleRepository>()));

    /* -- ViewModel -- */
    Get.put(
        ScheduleViewModel(
          getScheduleUseCase: Get.find<GetScheduleUseCase>(),
          createScheduleUseCase: Get.find<CreateScheduleUseCase>(),
          updateScheduleUseCase: Get.find<UpdateScheduleUseCase>(),
          deleteScheduleUseCase: Get.find<DeleteScheduleUseCase>(),
        ));
  }
}
