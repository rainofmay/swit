enum InvitationStatus { pending, accepted, rejected }

class GroupInvitation {
  final String id;
  final String groupId;
  final String invitedUserId;
  final String invitedById;
  final InvitationStatus status;
  final DateTime invitedAt;
  final DateTime? respondedAt;

  GroupInvitation({
    required this.id,
    required this.groupId,
    required this.invitedUserId,
    required this.invitedById,
    required this.status,
    required this.invitedAt,
    this.respondedAt,
  });

  bool canRespond() {
    // 예: 초대가 대기 중이고 7일 이내인 경우에만 응답 가능
    return status == InvitationStatus.pending &&
        DateTime.now().difference(invitedAt).inDays <= 7;
  }
}