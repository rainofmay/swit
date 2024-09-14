import 'package:swit/core/enums/online_status.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String? profileUrl;
  final OnlineStatus? onlineStatus;
  // 기타 필요한 사용자 정보

  User({this.profileUrl, this.onlineStatus, required this.id, required this.email, required this.name});
}