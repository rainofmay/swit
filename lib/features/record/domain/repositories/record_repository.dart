import 'package:swit/features/record/domain/entities/record_info.dart';
import 'package:swit/features/record/domain/entities/task.dart';

abstract class RecordRepository {
  Future getRecords();

  Future createRecord(RecordInfo recordInfo);

  Future updateRecord(String id, String newContents);

  Future deleteRecord(String id);
}