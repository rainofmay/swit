import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_time_dto.freezed.dart';
part 'record_time_dto.g.dart';

@freezed
class RecordTimeDTO with _$RecordTimeDTO {
  const factory RecordTimeDTO({
    // required String id,
    required String taskId,
    required String date,
    required int recordTime,
    String? contents,
  }) = _RecordTimeDTO;

  factory RecordTimeDTO.fromJson(Map<String, dynamic> json) => _$RecordTimeDTOFromJson(json);
}
