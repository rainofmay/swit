import 'package:swit/features/user/data/models/user_dto.dart';
import 'package:swit/features/user/domain/entities/user.dart';

abstract class MateRepository {
  Future fetchUserProfile();

  Future<List<User>> fetchPendingRequests();

  Future<List<User>> fetchMatesList();

  Future<void> sendMateRequestByEmail(String email);

  Future<List<User>> searchMate(String email);

  Future<void> acceptMateRequest(String requestId);

  Future<void> rejectMateRequest(String requestId);

  Future<void> deleteMate(String deleteUid);
}