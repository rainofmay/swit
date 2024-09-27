import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/utils/user/login_service.dart';

class MateRemoteDataSource {
  MateRemoteDataSource._internal();

  static final MateRemoteDataSource _instance = MateRemoteDataSource._internal();

  factory MateRemoteDataSource() {
    return _instance;
  }

  final supabase = Supabase.instance.client;
  final LoginService loginService = LoginService();

  /* -- Get -- */

  // 내가 아직 수락하지 않은 메이트 요청 목록
  Future<List<Map<String, dynamic>>> getPendingRequests(String userEmail) async {
    final userId = await supabase
        .from('users')
        .select('uid')
        .eq('email', userEmail)
        .single()
        .then((response) => response['uid']);

    return await supabase
        .from('mate_relationships')
        .select()
        .eq('receiver_id', userId)
        .eq('is_mate', false)
        .order('created_at');
  }


  // 내 메이트 리스트
  Future<List<Map<String, dynamic>>> getMatesList(String userId) async {
    return await supabase
        .from('mate_relationships')
        .select()
        .or('sender_id.eq.$userId, receiver_id.eq.$userId')
        .eq('is_mate', true)
        .order('created_at');
  }

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

  // 나를 팔로잉 하는 사람
  Future<List<Map<String, dynamic>>> getFollowingList(String userId) async {
    try {
      final response = await supabase
          .from('follows')
          .select('followed_id, body, users!follows_followed_id_fkey(*)')
          .eq('follower_id', userId)
          .order('created_at', ascending: false);

      return response;
    } catch (e) {
      print('Mate Remote Error fetching following list: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getFollowersList(String userId) async {
    try {
      final response = await supabase
          .from('follows')
          .select('follower_id, users!inner(*)')
          .eq('followed_id', userId)
          .order('created_at', ascending: false);

      return response;
    } catch (e) {
      print('Error fetching followers list: $e');
      return [];
    }
  }

  /* -- Post -- */

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


  // 메이트 요청 보내기
  Future<void> sendMateRequest(String senderId, String receiverId) async {
    await supabase
        .from('mate_relationships')
        .insert({
      'sender_id': senderId,
      'receiver_id': receiverId,
      'body' : '$senderId님이 메이트를 요청했습니다.'
    });
  }

  /* -- Update -- */
  // 메이트 요청 수락
  Future<void> acceptMateRequest(String requestId) async {
    final myId = await loginService.getMyId();
    final response = await supabase
        .from('mate_relationships')
        .select()
        .eq('sender_id', requestId)
        .eq('receiver_id', myId as Object); // receiver_id 확인 추가

    if (response.isNotEmpty) { // 요청이 존재하는 경우에만 승인 처리
      await supabase
          .from('mate_relationships')
          .update({'is_mate': true})
          .eq('sender_id', requestId)
          .eq('receiver_id', myId as Object); // receiver_id 조건 추가

      print("승인 완료!");
    } else {
      print("잘못된 요청입니다.");
      // 필요에 따라 에러 처리 추가 (예: 사용자에게 알림)
    }
  }

  /* -- Delete -- */

  // 메이트 요청 거절
  Future<void> rejectMateRequest(String requestId) async {
    final myId = await loginService.getMyId(); // 현재 사용자 ID 가져오기
    await supabase
        .from('mate_relationships')
        .delete()
        .eq('sender_id', requestId)
        .eq('receiver_id', myId as Object); // receiver_id 조건 추가

    print("거절 완료!");
  }

  Future<void> deleteMate(String deleteUid) async {
    final myId = await loginService.getCurrentUserId();
    try {
      final response = await supabase
          .from('mate_relationships')
          .delete()
          .filter('is_mate', 'eq', true)
          .or('sender_id.eq.$myId,receiver_id.eq.$deleteUid,sender_id.eq.$deleteUid,receiver_id.eq.$myId');

      print("메이트 삭제 완료!");
      // CustomSnackbar.show(title: '성공', message: '메이트가 삭제되었습니다.');
    } catch (e) {
      print('Error deleting mate: $e');
      // CustomSnackbar.show(title: '오류', message: '메이트 삭제 중 오류가 발생했습니다.');
    }
  }

  Future<bool> checkExistingRequest(String senderId, String receiverId) async {
    final existingRequest = await supabase
        .from('mate_relationships')
        .select()
        .eq('sender_id', senderId as String)
        .eq('receiver_id', receiverId);

    final isExisting = existingRequest.isNotEmpty;

    return isExisting;
  }

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