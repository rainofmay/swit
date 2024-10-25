import 'package:swit/core/utils/notification/notification_mapper.dart';
import 'package:swit/features/study/notification/data/datasources/notification_remote_data_source.dart';
import 'package:swit/features/study/notification/data/models/notification_dto.dart';
import 'package:swit/features/study/notification/domain/entities/notification_entity.dart';
import 'package:swit/features/study/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository{
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepositoryImpl(this.notificationRemoteDataSource);

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    try {
      final response = await notificationRemoteDataSource.getNotifications();

      // JSON 데이터를 DTO로 변환
      final notifications = response.map((json) => NotificationDTO.fromJson(json)).toList();

      // DTO를 Entity로 변환
      return NotificationMapper.toEntityList(notifications);
    } catch (e) {
      throw Exception('Error Repository getNotifications: $e');
    }
  }
}