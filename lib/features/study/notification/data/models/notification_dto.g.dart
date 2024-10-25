// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDTOImpl _$$NotificationDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationDTOImpl(
      id: json['id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      body: json['body'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$NotificationDTOImplToJson(
        _$NotificationDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'body': instance.body,
      'created_at': instance.createdAt.toIso8601String(),
    };
