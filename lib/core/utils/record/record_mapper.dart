import 'package:swit/features/record/data/models/record_time_dto.dart';
import 'package:swit/features/record/domain/entities/record_time.dart';
import 'package:swit/shared/constant/theme_color.dart';

class RecordMapper {
  static RecordTimeDTO toDTO(RecordTime record) {
    return RecordTimeDTO(
      taskId: record.taskId,
      date: record.date,
      recordTime: record.recordTime,
      contents: record.contents,
      title: record.title,
    );
  }

  static RecordTime toEntity(RecordTimeDTO dto) {
    return RecordTime(
      taskId: dto.taskId,
      date: dto.date,
      recordTime: dto.recordTime,
      contents: dto.contents,
      title: dto.title,
    );
  }

  static RecordTimeDTO fromJson(Map<String, dynamic> json) {
    return RecordTimeDTO(
      taskId: json['task_id'],
      date: json['date'],
      recordTime: json['record_time'],
      contents: json['contents'],
      title: json['task']['title'],  // 중첩된 JSON 객체에서 title 추출
    );
  }
}