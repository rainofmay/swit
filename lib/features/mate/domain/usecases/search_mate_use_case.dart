import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/mate/domain/repositories/mate_repository.dart';

class SearchMateUseCase {
  final MateRepository _mateRepository;

  SearchMateUseCase(this._mateRepository);

  Future<List<User>> execute(String email) async {
    return await _mateRepository.searchMate(email);
  }
}