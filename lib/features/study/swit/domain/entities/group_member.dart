class GroupMember {
  final String groupId;
  final String userId;
  final String role;
  final DateTime joinedAt;

  GroupMember({
    required this.groupId,
    required this.userId,
    required this.role,
    required this.joinedAt,
  });

  bool isAdmin() => role == 'admin';
}