import 'package:get/get.dart';
import 'package:swit/features/record/data/datasources/record_remote_data_source.dart';
import 'package:swit/features/record/data/datasources/task_remote_data_source.dart';
import 'package:swit/features/record/data/repsoitories/record_repository_impl.dart';
import 'package:swit/features/record/data/repsoitories/task_repository_impl.dart';
import 'package:swit/features/record/domain/repositories/record_repository.dart';
import 'package:swit/features/record/domain/repositories/task_repository.dart';
import 'package:swit/features/record/domain/usecases/task/create_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/task/delete_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/task/get_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/task/update_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/time_record/create_record_use_case.dart';
import 'package:swit/features/record/domain/usecases/time_record/delete_record_use_case.dart';
import 'package:swit/features/record/domain/usecases/time_record/get_record_use_case.dart';
import 'package:swit/features/record/domain/usecases/time_record/update_record_use_case.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';

class RecordBinding extends Bindings {
  @override
  void dependencies() {
    /* -- DataSource -- */
    Get.put(TaskRemoteDataSource());
    Get.put(RecordRemoteDataSource());

    /* -- Repository -- */
    Get.put<TaskRepository>(TaskRepositoryImpl(Get.find<TaskRemoteDataSource>()));
    Get.put<RecordRepository>(RecordRepositoryImpl(Get.find<RecordRemoteDataSource>()));

    /* -- UseCase -- */
    Get.put(GetTaskUseCase(Get.find<TaskRepository>()));
    Get.put(CreateTaskUseCase(Get.find<TaskRepository>()));
    Get.put(UpdateTaskUseCase(Get.find<TaskRepository>()));
    Get.put(DeleteTaskUseCase(Get.find<TaskRepository>()));

    Get.put(GetRecordUseCase(Get.find<RecordRepository>()));
    Get.put(CreateRecordUseCase(Get.find<RecordRepository>()));
    Get.put(UpdateRecordUseCase(Get.find<RecordRepository>()));
    Get.put(DeleteRecordUseCase(Get.find<RecordRepository>()));

    /* -- ViewModel -- */
    Get.put(RecordViewModel(
      getTaskUseCase: Get.find<GetTaskUseCase>(),
      createTaskUseCase: Get.find<CreateTaskUseCase>(),
      updateTaskUseCase: Get.find<UpdateTaskUseCase>(),
      deleteTaskUseCase: Get.find<DeleteTaskUseCase>(),
      getRecordsUseCase: Get.find<GetRecordUseCase>(),
      createRecordUseCase: Get.find<CreateRecordUseCase>(),
      updateRecordUseCase: Get.find<UpdateRecordUseCase>(),
      deleteRecordUseCase: Get.find<DeleteRecordUseCase>(),
    ));
  }

  void dispose() {
    /* -- View Model  제거 -- */
    Get.delete<RecordViewModel>();

    /* -- Use Case  제거 -- */
    Get.delete<GetTaskUseCase>();
    Get.delete<CreateTaskUseCase>();
    Get.delete<UpdateTaskUseCase>();
    Get.delete<DeleteTaskUseCase>();

    Get.delete<GetRecordUseCase>();
    Get.delete<CreateRecordUseCase>();
    Get.delete<UpdateRecordUseCase>();
    Get.delete<DeleteRecordUseCase>();

     /* -- Repository 제거 -- */
    Get.delete<TaskRepository>();
    Get.delete<RecordRepository>();
    /* -- DataSource 제거 -- */
    Get.delete<TaskRemoteDataSource>();
    Get.delete<TaskRemoteDataSource>();
  }
}