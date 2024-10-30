import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/data/base_remote_datasource.dart';
import 'package:uuid/uuid.dart';

class UserRemoteDataSource extends BaseRemoteDataSource{

  /* ------------------------------------------------------ */
  /* Get Fields ------------------------------------------- */
  /* ------------------------------------------------------ */
  Future<Map<String, dynamic>> fetchUserById(String userId) async {
    try {
      final response =
          await supabase.from('users').select().eq('uid', userId).single();
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
      if (profileUrl != null) updates['profile_url'] = profileUrl;

      // 사용자 정보 업데이트
      final response = await supabase.from('users').update(updates).eq('uid', userId).select().single();

      // 응답 확인
      if (response == null) {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('User Remote DataSource Error updating profile: $e');
      rethrow;
    }
  }

  Future<String> uploadProfileImage(File imageFile) async {
    try {
      final ext = path.extension(imageFile.path);
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final fileName = 'profile_$userId$ext';

      // 이미지 업로드 전에 기존 이미지 삭제
      try {
        final List<FileObject> files = await supabase.storage
            .from('profile_images')
            .list(path: '');

        final existingFile = files.firstWhere(
              (file) => file.name.startsWith('profile_$userId'),
          orElse: () => null as FileObject,
        );

        if (existingFile != null) {
          await supabase.storage
              .from('profile_images')
              .remove([existingFile.name]);
        }
      } catch (e) {
        print('Error removing existing image: $e');
      }

      // 새 이미지 업로드
      await supabase.storage
          .from('profile_images')
          .upload(fileName, imageFile, fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: true
      ));

      // 공개 URL 가져오기 전에 짧은 대기 시간 추가
      await Future.delayed(const Duration(milliseconds: 300));

      final imageUrl = supabase.storage
          .from('profile_images')
          .getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      print('Failed to upload profile image: $e');
      rethrow;
    }
  }
}
