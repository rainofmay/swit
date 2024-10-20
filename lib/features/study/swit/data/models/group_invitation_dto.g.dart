// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invitation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupInvitationDTOImpl _$$GroupInvitationDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupInvitationDTOImpl(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      invitedUserId: json['invited_user_id'] as String,
      invitedBy: json['invited_by'] as String,
      status: $enumDecode(_$InvitationStatusEnumMap, json['status']),
      invitedAt: DateTime.parse(json['invited_at'] as String),
      respondedAt: json['responded_at'] == null
          ? null
          : DateTime.parse(json['responded_at'] as String),
    );

Map<String, dynamic> _$$GroupInvitationDTOImplToJson(
        _$GroupInvitationDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'invited_user_id': instance.invitedUserId,
      'invited_by': instance.invitedBy,
      'status': _$InvitationStatusEnumMap[instance.status]!,
      'invited_at': instance.invitedAt.toIso8601String(),
      'responded_at': instance.respondedAt?.toIso8601String(),
    };

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.rejected: 'rejected',
};
