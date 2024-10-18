// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invitation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupInvitationDTOImpl _$$GroupInvitationDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupInvitationDTOImpl(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      invitedUserId: json['invitedUserId'] as String,
      invitedById: json['invitedById'] as String,
      status: json['status'] as String,
      invitedAt: DateTime.parse(json['invitedAt'] as String),
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
    );

Map<String, dynamic> _$$GroupInvitationDTOImplToJson(
        _$GroupInvitationDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'invitedUserId': instance.invitedUserId,
      'invitedById': instance.invitedById,
      'status': instance.status,
      'invitedAt': instance.invitedAt.toIso8601String(),
      'respondedAt': instance.respondedAt?.toIso8601String(),
    };
