import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_dto.freezed.dart';
part 'notification_dto.g.dart';

@freezed
class NotificationDTO with _$NotificationDTO {

  const factory NotificationDTO({
    required String id,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'receiver_id') required String receiverId,
    required String body,
    @JsonKey(name: 'created_at') required DateTime createdAt,

  }) = _NotificationDTO;

  factory NotificationDTO.fromJson(Map<String, dynamic> json) =>
      _$NotificationDTOFromJson(json);
}