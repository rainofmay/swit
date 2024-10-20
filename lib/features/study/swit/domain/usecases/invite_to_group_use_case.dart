import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';
import 'package:swit/features/study/swit/domain/repositories/study_group_repository.dart';

class InviteToGroupUseCase {
  final StudyGroupRepository repository;
  InviteToGroupUseCase(this.repository);

  Future<GroupInvitation> execute(String groupId, String invitedUserId) async {
    return await repository.inviteToGroup(groupId, invitedUserId);
  }
}