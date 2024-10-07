import 'package:swit/features/record/domain/entities/record_info.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/record_repository.dart';

class CreateRecordUseCase {
  final RecordRepository repository;
  CreateRecordUseCase(this.repository);

  Future execute(RecordInfo recordInfo) async {
    await repository.createRecord(recordInfo);
  }
}