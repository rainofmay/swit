import 'package:intl/intl.dart';
import 'package:swit/features/record/data/models/record_info_dto.dart';
import 'package:swit/features/record/domain/entities/record_info.dart';
import 'package:swit/shared/constant/theme_color.dart';

class RecordMapper {
  // static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  static RecordInfoDTO toDTO(RecordInfo record) {
    return RecordInfoDTO(
      id: record.id,
      date: record.date,
      recordTime: record.recordTime,
      contents: record.contents,
      title: record.title,
    );
  }

  static RecordInfo toEntity(RecordInfoDTO dto) {
    return RecordInfo(
      id: dto.id,
      date: dto.date,
      recordTime: dto.recordTime,
      contents: dto.contents,
      title: dto.title,
    );
  }

  static RecordInfoDTO fromJson(Map<String, dynamic> json) {
    return RecordInfoDTO(
      id: json['id'],
      date: json['date'],
      recordTime: json['record_time'],
      contents: json['contents'],
      title: json['title'], // 중첩된 JSON 객체에서 title 추출
    );
  }
}