import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/mate/domain/repositories/mate_repository.dart';

class GetUserProfileUseCase {
  final MateRepository _mateRepository;

  GetUserProfileUseCase(this._mateRepository);

  Future<User> getUserProfile() async {
    return await _mateRepository.fetchUserProfile();
  }
}