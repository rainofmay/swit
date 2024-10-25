class NotificationEntity {
  final String id;
  final String senderId;
  final String receiverId;
  final String body;
  final DateTime createdAt;

  NotificationEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.body,
    required this.createdAt,
  });
}