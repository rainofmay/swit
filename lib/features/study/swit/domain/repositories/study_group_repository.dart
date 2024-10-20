import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';
import 'package:swit/features/study/swit/domain/entities/study_group.dart';

abstract class StudyGroupRepository {

  Future<StudyGroup> createStudyGroup(String name, String description);

  Future<GroupInvitation> inviteToGroup(String groupId, String invitedUserId);
}