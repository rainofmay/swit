import 'package:swit/features/mate/domain/repositories/mate_repository.dart';

class UnfollowMateUseCase {
  final MateRepository _mateRepository;

  UnfollowMateUseCase(this._mateRepository);

  Future<void> execute(String unfollowedId) async {
    await _mateRepository.unfollowMate(unfollowedId);
  }
}