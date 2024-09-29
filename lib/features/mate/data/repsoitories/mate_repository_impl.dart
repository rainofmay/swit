import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/core/utils/user/user_mapper.dart';
import 'package:swit/features/mate/data/datasources/mate_remote_data_source.dart';
import 'package:swit/features/mate/domain/repositories/mate_repository.dart';
import 'package:swit/features/user/data/models/user_dto.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/shared/widgets/custom_snackbar.dart';

class MateRepositoryImpl implements MateRepository {
  final MateRemoteDataSource _mateRemoteDataSource;
  final LoginService _loginService;

  MateRepositoryImpl(this._mateRemoteDataSource, this._loginService);

  @override
  Future<User> fetchUserProfile() async {
    try {
      // 현재 사용자의 ID 가져오기
      final userId = await _loginService.getMyId();
      // print('userId $userId');

      // 사용자 정보 가져오기
      final fetchedData = await _loginService.getUserById(userId!);

      UserDTO userDTO = UserDTO.fromJson(fetchedData);
      // 사용자 정보를 User Entity 객체로 변환
      User user = UserMapper.toEntity(userDTO);

      return user;

    } catch (e) {
      throw Exception('Failed to fetch User profile: ${e.toString()}');
    }
  }

  @override
  Future<List<User>> searchMate(String email) async {
    try {
      final response = await _mateRemoteDataSource.searchMate(email);

      // response가 List<Map<String, dynamic>>이므로 직접 매핑합니다.
      List<User> users = response.map((userData) {
        // UserDTO 생성
        UserDTO userDTO = UserDTO.fromJson(userData);

        // UserDTO를 User 엔티티로 변환
        return UserMapper.toEntity(userDTO);
      }).toList();

      return users;
    } catch (e) {
      print('Mate RepositoryImpl Error searching users: $e');
      return [];
    }
  }

  @override
  Future<void> followMate(String followedId) async {
    try {
      final follower = await _loginService.getMyId();
      if (follower != null) {
        await _mateRemoteDataSource.followMate(followedId, "팔로우 메시지");
      } else {
        throw Exception('현재 사용자 ID를 가져올 수 없습니다.');
      }
    } catch (e) {
      print('Mate RepositoryImpl Error follow mate: $e');
      rethrow;
    }
  }

  @override
  Future<void> unfollowMate(String unfollowedId) async {
    try {
      await _mateRemoteDataSource.unfollowMate(unfollowedId);
    } catch (e) {
      print('Mate RepositoryImpl Error unfollow mate: $e');
      rethrow;
    }
  }

  @override
  Future<List<User>> fetchFollowingList() async {
    try {
      final userId = await _loginService.getMyId();
      final response = await _mateRemoteDataSource.getFollowingList(userId!);

      return response.map((userData) {
        return UserMapper.toEntity(UserDTO.fromJson(userData['users']));
      }).toList();
    } catch (e) {
      print('RepositoryImpl Error fetching following list: $e');
      return [];
    }
  }


  /* 친구 승인 시 Notification */
  // Future<void> mateAcceptNotification(String requestId) async {
  //   final accepterEmail = await AuthHelper.getCurrentUserEmail();
  //   final acceptId = await getUserIdByEmail(accepterEmail!);
  //   final acceptName = await AuthHelper.getNicknameById(acceptId!);
  //
  //   try {
  //     // final requestData = await supabase
  //     //     .from('users')
  //     //     .select('nickname')
  //     //     .eq('id', requestId)
  //     //     .single();
  //     //
  //     // if (requestData == null) {
  //     //   throw Exception('Requester not found');
  //     // }
  //     //
  //     // final requesterName = requestData['nickname'] as String;
  //
  //     await supabase.from('notifications').insert({
  //       'sender_id': acceptId, // 승인하는 사용자
  //       'receiver_id': requestId, // 요청했던 사용자(에게 알림이 가야함)
  //       'body': '$acceptName님이 메이트 요청을 승인했습니다.'
  //     });
  //   } catch (error) {
  //     print('Error requesting mate request notification: $error');
  //   }
  // }

}