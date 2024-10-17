import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class UserRemoteDataSource {
  UserRemoteDataSource._internal();

  static final UserRemoteDataSource _instance =
  UserRemoteDataSource._internal();

  factory UserRemoteDataSource() {
    return _instance;
  }

  final supabase = Supabase.instance.client;

  /* ------------------------------------------------------ */
  /* Get Fields ------------------------------------------- */
  /* ------------------------------------------------------ */
  Future<Map<String, dynamic>> fetchUserById(String userId) async {
    try {
      final response = await supabase.from('users').select().eq('uid', userId).single();
      if (response == null) {
        throw Exception('User not found');
      }
      return response;
    } catch (e) {
      print('Error fetching user: $e');
      rethrow;
    }
  }

  /* ------------------------------------------------------ */
  /* Update Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  Future<void> updateMyProfile(
      {required String userId,
      String? username,
      String? introduction,
      String? profileUrl}) async {
    try {
      Map<String, dynamic> updates = {};

      if (username != null) updates['username'] = username;
      if (introduction != null) updates['introduction'] = introduction;

      // 프로필 이미지 수정일 경우 Storage에 업로드
      // profileUrl이 file path인지 체크
      if (profileUrl != null && File(profileUrl).existsSync()) {
        //profileUrl이 파일 경로인 경우 자동을 이미지 업로드하고 URL 반환
        String uploadedUrl = await _uploadProfileImage(File(profileUrl));
        updates['profile_url'] = uploadedUrl;
      } else if (profileUrl != null) {
        // 이미 유효한 경우 URL 그대로 사용
        updates['profile_url'] = profileUrl;
      }


      // 사용자 정보 업데이트
      await supabase.from('users').update(updates).eq('uid', userId);

    } catch (e) {
      print('User Remote DataSource Error updating profile: $e');
      rethrow;
    }
  }

  Future<String> _uploadProfileImage(File imageFile) async {
    try {
      final String fileName = '${Uuid().v4()}${path.extension(imageFile.path)}';
      final String storagePath = 'profile_images/$fileName';

      final response = await supabase
          .storage
          .from('profile_images')  // Supabase 버킷 이름
          .upload(storagePath, imageFile);


      // 업로드된 이미지의 공개 URL 반환
      return supabase.storage.from('profile_images').getPublicUrl(storagePath);
    } catch (e) {
      print('User Remote DataSource Error uploading profile image: $e');
      rethrow;
    }
  }

}
