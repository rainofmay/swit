import 'package:get/get.dart';
import 'package:swit/features/record/data/datasources/task_remote_data_source.dart';
import 'package:swit/features/record/data/repsoitories/task_repository_impl.dart';
import 'package:swit/features/record/domain/repositories/task_repository.dart';
import 'package:swit/features/record/domain/usecases/create_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/delete_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/get_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/update_task_use_case.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';

class RecordBinding extends Bindings {
  @override
  void dependencies() {
    /* -- DataSource -- */
    Get.put<TaskRemoteDataSource>(TaskRemoteDataSource());

    /* -- Repository -- */
    Get.put<TaskRepository>(
      TaskRepositoryImpl(Get.find<TaskRemoteDataSource>()),
    );

    /* -- UseCase -- */
    Get.put(GetTaskUseCase(Get.find<TaskRepository>()));
    Get.put(CreateTaskUseCase(Get.find<TaskRepository>()));
    Get.put(UpdateTaskUseCase(Get.find<TaskRepository>()));
    Get.put(DeleteTaskUseCase(Get.find<TaskRepository>()));

    /* -- ViewModel -- */
    Get.lazyPut(() =>
        RecordViewModel(getTaskUseCase: Get.find<GetTaskUseCase>(),
            createTaskUseCase: Get.find<CreateTaskUseCase>(),
            updateTaskUseCase: Get.find<UpdateTaskUseCase>(),
            deleteTaskUseCase: Get.find<DeleteTaskUseCase>())
    );
  }

  void dispose() {
    // ViewModel 제거
    Get.delete<RecordViewModel>();

    // Use Case 제거
    Get.delete<GetTaskUseCase>();
    Get.delete<CreateTaskUseCase>();
    Get.delete<UpdateTaskUseCase>();
    Get.delete<DeleteTaskUseCase>();

    // Repository 제거
    Get.delete<TaskRepository>();

    // DataSource 제거
    Get.delete<TaskRemoteDataSource>();
  }
}