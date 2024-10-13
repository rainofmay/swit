import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_info_dto.freezed.dart';
part 'record_info_dto.g.dart';

@freezed
class RecordInfoDTO with _$RecordInfoDTO {
  const factory RecordInfoDTO({
    required String id,
    required String taskId,
    required String date,
    required int recordTime,
    String? contents,
    required String title,
  }) = _RecordInfoDTO;

  factory RecordInfoDTO.fromJson(Map<String, dynamic> json) => _$RecordInfoDTOFromJson(json);
}
