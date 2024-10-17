import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
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
      throw Exception('User Repository Failed to fetch User profile: $e');
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

  @override
  Future<String> uploadProfileImage(File imageFile) async {
    // 이미지 압축
    final compressedImage = await compressImage(imageFile);

    // 압축된 이미지 업로드
    return await _remoteDataSource.uploadProfileImage(compressedImage);
  }

  Future<File> compressImage(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = path.join(dir.absolute.path, "${path.basename(file.path)}_compressed.jpg");

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      // 필요 시 다른 압축 옵션 추가
      // 예: minWidth: 1024, minHeight: 1024,
    );

    return File(result!.path);
  }
}
