import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/core/utils/user/user_mapper.dart';
import 'package:swit/features/user/data/datasources/user_remote_data_source.dart';
import 'package:swit/features/user/data/models/user_dto.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final LoginService _loginService;

  UserRepositoryImpl(this._remoteDataSource, this._loginService);

  @override
  Future<User> fetchMyProfile() async {
    try {
      final userId = await _loginService.getMyId();
      if (userId == null) throw Exception('User not authenticated');

      final fetchedData = await _remoteDataSource.fetchUserById(userId);
      UserDTO userDTO = UserDTO.fromJson(fetchedData);
      return UserMapper.toEntity(userDTO);
    } catch (e) {
      throw Exception('Failed to fetch User profile: $e');
    }
  }

  @override
  Future<void> updateMyProfile(
      {required String userId,
      String? username,
      String? introduction,
      String? profileUrl}) async {
    await _remoteDataSource.updateMyProfile(
        userId: userId,
        username: username,
        introduction: introduction,
        profileUrl: profileUrl);
  }
}
