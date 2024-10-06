import 'package:swit/features/record/data/models/record_time_dto.dart';
import 'package:swit/features/record/domain/entities/record_time.dart';
import 'package:swit/shared/constant/theme_color.dart';

class RecordMapper {
  static RecordTimeDTO toDTO(RecordTime record) {
    return RecordTimeDTO(
      // id: record.id,
      taskId: record.taskId,
      date: record.date,
      recordTime: record.recordTime,
      contents: record.contents,
    );
  }

  static RecordTime toEntity(RecordTimeDTO dto) {
    return RecordTime(
      // id: dto.id,
      taskId: dto.taskId,
      date: dto.date,
      recordTime: dto.recordTime,
      contents: dto.contents,
    );
  }
}