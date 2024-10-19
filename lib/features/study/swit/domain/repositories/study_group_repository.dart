abstract class StudyGroupRepository {

  Future<void> createStudyGroup();

  Future<void> inviteToGroup(String groupId, String invitedUserId);
}