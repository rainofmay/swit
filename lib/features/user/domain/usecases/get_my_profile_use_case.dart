import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/repositories/user_repository.dart';

class GetMyProfileUseCase {
  final UserRepository _userRepository;

  GetMyProfileUseCase(this._userRepository);

  Future<User> execute() async {
    return await _userRepository.fetchMyProfile();
  }
}