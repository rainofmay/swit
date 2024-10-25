import 'package:swit/features/study/notification/data/models/notification_dto.dart';
import 'package:swit/features/study/notification/domain/entities/notification_entity.dart';

class NotificationMapper {
  static NotificationEntity toEntity(NotificationDTO dto) {
    return NotificationEntity(
      id: dto.id,
      senderId: dto.senderId,
      receiverId: dto.receiverId,
      body: dto.body,
      createdAt: dto.createdAt,
    );
  }

  static NotificationDTO toDTO(NotificationEntity entity) {
    return NotificationDTO(
      id: entity.id,
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      body: entity.body,
      createdAt: entity.createdAt,
    );
  }

  static List<NotificationEntity> toEntityList(List<NotificationDTO> dtoList) {
    return dtoList.map((dto) => toEntity(dto)).toList();
  }
}