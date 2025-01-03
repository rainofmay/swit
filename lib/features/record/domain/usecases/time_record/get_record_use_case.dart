import 'package:swit/features/record/domain/entities/record_info.dart';
import 'package:swit/features/record/domain/repositories/record_repository.dart';

class GetRecordUseCase {
  final RecordRepository repository;

  GetRecordUseCase(this.repository);

  Future<List<RecordInfo>> execute() async {
    return await repository.getRecords();
  }
}