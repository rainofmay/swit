// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupMemberDTOImpl _$$GroupMemberDTOImplFromJson(Map<String, dynamic> json) =>
    _$GroupMemberDTOImpl(
      groupId: json['group_id'] as String,
      userId: json['user_id'] as String,
      role: json['role'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
    );

Map<String, dynamic> _$$GroupMemberDTOImplToJson(
        _$GroupMemberDTOImpl instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
      'user_id': instance.userId,
      'role': instance.role,
      'joined_at': instance.joinedAt.toIso8601String(),
    };
