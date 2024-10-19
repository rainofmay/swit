
import 'package:swit/features/study/swit/data/models/group_invitation_dto.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';

class GroupInvitationMapper {
  static GroupInvitation fromDto(GroupInvitationDTO dto) {
    return GroupInvitation(
      id: dto.id,
      groupId: dto.groupId,
      invitedUserId: dto.invitedUserId,
      invitedAt: dto.invitedAt,
      invitedById: dto.invitedById,
      respondedAt: dto.respondedAt,
      status: dto.status,
    );
  }
}