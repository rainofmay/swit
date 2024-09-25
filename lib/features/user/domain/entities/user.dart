import 'package:swit/app/enums/online_status.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String profileUrl;
  final String? introduction;
  final OnlineStatus? onlineStatus;
  // 기타 필요한 사용자 정보

  User({required this.uid, required this.email, required this.username, required this.profileUrl, this.introduction, this.onlineStatus});
}