import 'package:swit/features/record/domain/entities/record_time.dart';
import 'package:swit/features/record/domain/repositories/record_repository.dart';

class GetRecordUseCase {
  final RecordRepository repository;

  GetRecordUseCase(this.repository);

  Future<List<RecordTime>> execute() async {
    return await repository.getRecords();
  }
}