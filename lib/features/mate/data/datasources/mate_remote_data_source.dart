import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/data/base_remote_datasource.dart';
import 'package:swit/core/utils/user/login_service.dart';

class MateRemoteDataSource extends BaseRemoteDataSource {

  final LoginService loginService = LoginService();


/* ------------------------------------------------------ */
/* Get Fields ------------------------------------------- */
/* ------------------------------------------------------ */

  // 메이트 찾기
  Future<List<Map<String, dynamic>>> searchMate(String email) async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .ilike('email', '%$email%');

      return response;
    } catch (e) {
      print('Remote data source, Error searching mate: $e');
      return [];
    }
  }

  // 내가 팔로우 하는 사람 목록
  Future<List<Map<String, dynamic>>> getFollowingList(String userId) async {
    try {
      final response = await supabase
          .from('follows')
          .select('followed_id, users!follows_followed_id_fkey(*)')
          .eq('follower_id', userId)
          .order('created_at', ascending: false);

      return response;
    } catch (e) {
      print('Mate Remote Error fetching following list: $e');
      return [];
    }
  }

  // 나를 팔로우 하는 사람 목록
  Future<List<Map<String, dynamic>>> getFollowersList(String userId) async {
    try {
      final response = await supabase
          .from('follows')
          .select('follower_id, users!follows_follower_id_fkey(*)')
          .eq('followed_id', userId)
          .order('created_at', ascending: false);

      return response;
    } catch (e) {
      print('Mate Remote Error fetching follower list: $e');
      return [];
    }
  }

  /* ------------------------------------------------------ */
  /* Create Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  // 메이트 팔로우 하기
  Future<void> followMate(String followedUid, String message) async {
    try {
      await supabase.rpc('follow_user', params: {
        'follower_uid': supabase.auth.currentUser!.id,
        'followed_uid': followedUid,
        'follow_message': message
      });
      // 성공 처리
    } catch (error) {
      print('Mate remote followUser error : $error');
    }
  }


  /* ------------------------------------------------------ */
  /* Delete Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  // 메이트 언팔로우 하기
  Future<void> unfollowMate(String followedUid) async {
    try {
      await supabase.rpc('unfollow_user', params: {
        'follower_uid': supabase.auth.currentUser!.id,
        'followed_uid': followedUid
      });
      // 성공 처리
    } catch (error) {
      print('Mate remote unfollowUser error : $error');
    }
  }
}