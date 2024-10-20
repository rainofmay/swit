import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';

part 'group_invitation_dto.freezed.dart';
part 'group_invitation_dto.g.dart';

@freezed
class GroupInvitationDTO with _$GroupInvitationDTO {

  const factory GroupInvitationDTO({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'invited_user_id') required String invitedUserId,
    @JsonKey(name: 'invited_by') required String invitedBy,
    required InvitationStatus status,
    @JsonKey(name: 'invited_at') required DateTime invitedAt,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
  }) = _GroupInvitationDTO;

  factory GroupInvitationDTO.fromJson(Map<String, dynamic> json) =>
      _$GroupInvitationDTOFromJson(json);
}