import 'package:get/get.dart';
import 'package:swit/features/study/notification/data/datasources/notification_remote_data_source.dart';
import 'package:swit/features/study/notification/data/repositories/notification_repository_impl.dart';
import 'package:swit/features/study/notification/domain/repositories/notification_repository.dart';
import 'package:swit/features/study/notification/domain/usecases/get_notification_use_case.dart';
import 'package:swit/features/study/notification/presentation/viewmodel/notification_view_model.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    /* -- Data source -- */
    Get.put<NotificationRemoteDataSource>(
      NotificationRemoteDataSource(),
    );

    /* -- Repository -- */
    Get.put<NotificationRepository>(
      NotificationRepositoryImpl(
        Get.find<NotificationRemoteDataSource>(),
      ),
    );

    /* -- Use Case -- */
    Get.put<GetNotificationUseCase>(
      GetNotificationUseCase(
        Get.find<NotificationRepository>(),
      ),
    );

    /* -- View Model -- */
    Get.put(
      NotificationViewModel(
        getNotificationUseCase: Get.find<GetNotificationUseCase>(),
      ),
    );
  }
}