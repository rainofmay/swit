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
  Future<List<User>> fetchPendingRequests() async {
    try {
      final userEmail = await _loginService.getCurrentUserEmail();
      final response = await _mateRemoteDataSource.getPendingRequests(
          userEmail!);

      // 메이트 ID 목록 생성
      final mateIDs = response.map((mate) => mate['sender_id'] as String)
          .toList();

      // 메이트 ID 목록을 사용하여 사용자 정보 가져오기
      final userDTOs = await _loginService.getUsersByIds(mateIDs);
      return userDTOs.map((userData) => UserMapper.toEntity(UserDTO.fromJson(userData))).toList();

    } catch (e) {
      throw Exception('Failed to fetch pending requests: ${e.toString()}');
    }
  }

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
  Future<List<User>> fetchMatesList() async {
    try {
      // 현재 사용자의 ID 가져오기
      final userId = await _loginService.getMyId();

      // 친구 관계 데이터 가져오기
      final response = await _mateRemoteDataSource.getMatesList(userId!);

      // 친구 ID 목록 생성
      final mateIDs = response.map((mate) {
        return mate['sender_id'] == userId
            ? mate['receiver_id'] as String
            : mate['sender_id'] as String;
      }).toList();

      // 친구 ID 목록을 사용하여 사용자 정보 가져오기
      final userDTOs = await _loginService.getUsersByIds(mateIDs);

      // 사용자 정보를 User Entity 객체로 변환
      return userDTOs.map((userData) => UserMapper.toEntity(UserDTO.fromJson(userData))).toList();
    } catch (e) {
      throw Exception('Failed to fetch Mates List: ${e.toString()}');
    }
  }

  @override
  Future<void> acceptMateRequest(String requestId) async {
    try {
      await _mateRemoteDataSource.acceptMateRequest(requestId);
      // // 승인 Notification
      // await mateAcceptNotification(requestId);

      // fetchMatesList();
    }
    catch (e) {
      print('$e');
    }
  }

  @override
  Future<List<User>> searchMate(String email) async {
    try {
      final response = await _mateRemoteDataSource.searchMate(email);
      if (response.error != null) {
        throw response.error!;
      }

      List<User> users = response.map((userData) {
        // 'similarity' 필드를 제거
        Map<String, dynamic> userMap = Map<String, dynamic>.from(userData);
        userMap.remove('similarity');

        // UserDTO 생성
        UserDTO userDTO = UserDTO.fromJson(userMap);

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
  Future<void> sendMateRequestByEmail(String email) async {
    try {
      final userEmail = await _loginService.getCurrentUserEmail();
      final receiverId = await _loginService.getUserIdByEmail(email);
      final senderId = await _loginService.getUserIdByEmail(userEmail!);
      if (receiverId != null &&
          email != userEmail) { // 사용자가 존재하고, 자신에게 요청을 보내는 것이 아닌 경우
        // 이미 친구 요청을 보냈는지 확인
        final existingRequest = await _mateRemoteDataSource.checkExistingRequest(senderId!, receiverId);

        if (existingRequest) { // 이미 요청을 보낸 경우
          CustomSnackbar.show(
              title: '알림', message: '이미 해당 사용자에게 메이트 요청을 보냈습니다.');
        } else { // 새로운 요청을 보내는 경우
          await _mateRemoteDataSource.sendMateRequest(senderId, receiverId);
          // await mateRequestNotification(
          // senderUserId, receiverUserId); // Notification
          CustomSnackbar.show(title: '완료', message: '메이트 요청을 보냈습니다.');
        }
      } else if (email == userEmail) { // 자신에게 요청을 보내는 경우
        CustomSnackbar.show(title: '오류', message: '자신에게 메이트 요청을 보낼 수 없습니다.');
      } else { // 사용자를 찾을 수 없는 경우
        CustomSnackbar.show(title: '오류', message: '해당 이메일의 사용자를 찾을 수 없습니다.');
      }
    } catch (e) {
      // 에러 처리
      print('Error sending mate request: $e');
    }
  }

  @override
  Future<void> deleteMate(String deleteUid) async {
    await _mateRemoteDataSource.deleteMate(deleteUid);
    // fetchMatesList();
  }

  @override
  Future<void> rejectMateRequest(String requestId) async {
    await _mateRemoteDataSource.rejectMateRequest(requestId);
    // fetchMatesList();
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