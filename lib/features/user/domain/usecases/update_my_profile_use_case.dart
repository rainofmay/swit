
import 'package:swit/features/user/domain/repositories/user_repository.dart';

class UpdateMyProfileUseCase {
  final UserRepository _repository;

  UpdateMyProfileUseCase(this._repository);

  Future<void> execute({required String userId, String? username, String? introduction, String? profileUrl}) async {
    await _repository.updateMyProfile(userId: userId, username: username, introduction: introduction, profileUrl: profileUrl);
  }
}


