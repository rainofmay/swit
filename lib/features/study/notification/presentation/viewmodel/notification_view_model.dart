import 'package:get/get.dart';
import 'package:swit/features/study/notification/domain/entities/notification_entity.dart';
import 'package:swit/features/study/notification/domain/usecases/get_notification_use_case.dart';

class NotificationViewModel extends GetxController {
  final GetNotificationUseCase _getNotificationUseCase;

  NotificationViewModel(
      {required GetNotificationUseCase getNotificationUseCase})
      : _getNotificationUseCase = getNotificationUseCase;

  final RxList<NotificationEntity> _notificationList = <NotificationEntity>[].obs;
  List<NotificationEntity> get notificationList => _notificationList

  ;
  @override
  void onInit() {
    super.onInit();

    getNotifications();
  }


  Future<void> getNotifications() async {
    try {
      final notifications = await _getNotificationUseCase.execute();
      _notificationList.assignAll(notifications);
    } catch (e) {
      print('Notification View model getNotifications Error : $e');
    }
  }

  // 새로고침
  Future<void> refreshNotifications() async {
    await getNotifications();
  }
}
