import 'package:swit/features/record/domain/entities/record_time.dart';
import 'package:swit/features/record/domain/entities/task.dart';

abstract class RecordRepository {
  Future createRecord(RecordTime recordTime);
}