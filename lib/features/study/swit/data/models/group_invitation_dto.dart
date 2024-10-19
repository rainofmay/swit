import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';

part 'group_invitation_dto.freezed.dart';
part 'group_invitation_dto.g.dart';

@freezed
class GroupInvitationDTO with _$GroupInvitationDTO {

  const factory GroupInvitationDTO({
    required String id,
    required String groupId,
    required String invitedUserId,
    required String invitedById,
    required InvitationStatus status,
    required DateTime invitedAt,
    DateTime? respondedAt,
  }) = _GroupInvitationDTO;

  factory GroupInvitationDTO.fromJson(Map<String, dynamic> json) =>
      _$GroupInvitationDTOFromJson(json);
}