import 'package:swit/features/mate/domain/repositories/mate_repository.dart';
import 'package:swit/features/user/domain/entities/user.dart';

class GetFollowerListUseCase {
  final MateRepository _mateRepository;

  GetFollowerListUseCase(this._mateRepository);

  Future<List<User>> execute() async {
    final fetchedData = await _mateRepository.fetchFollowerList();
    return fetchedData;
  }
}