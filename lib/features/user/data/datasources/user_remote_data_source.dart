import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class UserRemoteDataSource {
  UserRemoteDataSource._internal();

  static final UserRemoteDataSource _instance =
      UserRemoteDataSource._internal();

  factory UserRemoteDataSource() => _instance;

  final supabase = Supabase.instance.client;

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
      await supabase.from('users').update(updates).eq('uid', userId);
    } catch (e) {
      print('User Remote DataSource Error updating profile: $e');
    }
  }

  Future<String> uploadProfileImage(File imageFile) async {
    try {
      final ext = path.extension(imageFile.path);
      final fileName = '${const Uuid().v4()}$ext';

      await supabase.storage.from('profile_images').upload(fileName, imageFile);

      final imageUrl =
          supabase.storage.from('profile_images').getPublicUrl(fileName);
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }
}
