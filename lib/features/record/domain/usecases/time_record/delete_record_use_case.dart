import 'package:swit/features/record/domain/entities/record_info.dart';
import 'package:swit/features/record/domain/repositories/record_repository.dart';

class DeleteRecordUseCase {
  final RecordRepository repository;
  DeleteRecordUseCase(this.repository);

  Future execute(String id) async {
    await repository.deleteRecord(id);
  }
}