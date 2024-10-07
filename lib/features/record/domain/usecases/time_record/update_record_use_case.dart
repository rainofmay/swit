import 'package:swit/features/record/domain/repositories/record_repository.dart';

class UpdateRecordUseCase {
  final RecordRepository repository;
  UpdateRecordUseCase(this.repository);

  Future execute(String id, String newContents) async {
    await repository.updateRecord(id, newContents);
  }
}