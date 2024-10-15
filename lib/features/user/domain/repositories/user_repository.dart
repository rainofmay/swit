abstract class UserRepository {
  Future<void> updateMyProfile({required String userId, String? username, String? introduction, String? profileUrl});
}