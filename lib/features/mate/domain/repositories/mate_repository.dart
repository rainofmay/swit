import 'package:swit/features/user/data/models/user_dto.dart';
import 'package:swit/features/user/domain/entities/user.dart';

abstract class MateRepository {

  Future<List<User>> searchMate(String email);

  Future<void> followMate(String followedId);

  Future<void> unfollowMate(String unfollowedId);

  Future<List<User>> fetchFollowingList();

  Future<List<User>> fetchFollowerList();
}