import 'package:swit/features/study/notification/domain/entities/notification_entity.dart';
import 'package:swit/features/study/notification/domain/repositories/notification_repository.dart';

class GetNotificationUseCase {
  final NotificationRepository repository;
  GetNotificationUseCase(this.repository);

  Future<List<NotificationEntity>> execute() async {
    return await repository.getNotifications();
  }
}