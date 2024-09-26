import 'package:swit/features/mate/domain/repositories/mate_repository.dart';
import 'package:swit/features/user/domain/entities/user.dart';

class GetFollowingListUseCase {
  final MateRepository _mateRepository;

  GetFollowingListUseCase(this._mateRepository);

  Future<List<User>> execute() async {
    final fetchedData = await _mateRepository.fetchFollowingList();
    return fetchedData;
  }
}