import 'package:swit/features/mate/domain/repositories/mate_repository.dart';
import 'package:swit/features/user/domain/entities/user.dart';

class FollowMateUseCase {
  final MateRepository _mateRepository;

  FollowMateUseCase(this._mateRepository);

  Future<void> execute(String followedId) async {
    await _mateRepository.followMate(followedId);
  }
}