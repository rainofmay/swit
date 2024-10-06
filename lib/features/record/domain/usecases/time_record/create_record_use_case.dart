import 'package:swit/features/record/domain/entities/record_time.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/record_repository.dart';

class CreateRecordUseCase {
  final RecordRepository repository;
  CreateRecordUseCase(this.repository);

  Future execute(RecordTime recordTime) async {
    await repository.createRecord(recordTime);
  }
}