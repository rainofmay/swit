import 'package:swit/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> fetchMyProfile();

  Future<void> updateMyProfile({required String userId, String? username, String? introduction, String? profileUrl});
}