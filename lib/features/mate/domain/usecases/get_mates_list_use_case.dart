import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/mate/domain/repositories/mate_repository.dart';

class GetMatesListUseCase {
  final MateRepository _mateRepository;

  GetMatesListUseCase(this._mateRepository);

  Future<List<User>> execute() async {
    return await _mateRepository.fetchMatesList();
  }
}