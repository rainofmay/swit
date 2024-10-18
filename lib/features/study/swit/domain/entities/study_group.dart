class StudyGroup {
  final String groupId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final String createdById;
  final bool isActive;

  StudyGroup({
    required this.groupId,
    required this.name,
    this.description,
    required this.createdAt,
    required this.createdById,
    required this.isActive,
  });

  // 비즈니스 로직 메서드
  bool canInviteMembers() {
    // 그룹이 활성 상태이고 생성된 지 30일 이내인 경우에만 초대 가능
    // return isActive && DateTime.now().difference(createdAt).inDays <= 30;
    return isActive;
  }
}