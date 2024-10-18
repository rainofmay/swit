// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupMemberDTOImpl _$$GroupMemberDTOImplFromJson(Map<String, dynamic> json) =>
    _$GroupMemberDTOImpl(
      groupId: json['groupId'] as String,
      userId: json['userId'] as String,
      role: json['role'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$$GroupMemberDTOImplToJson(
        _$GroupMemberDTOImpl instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'userId': instance.userId,
      'role': instance.role,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };
