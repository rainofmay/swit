import 'package:swit/features/user/data/datasources/user_remote_data_source.dart';
import 'package:swit/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> updateMyProfile({required String userId, String? username, String? introduction, String? profileUrl}) async {
    await _remoteDataSource.updateMyProfile(userId: userId, username: username, introduction: introduction, profileUrl: profileUrl);
  }
}