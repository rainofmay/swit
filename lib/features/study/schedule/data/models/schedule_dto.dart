import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swit/core/utils/schedule/datetime_converter.dart';

part 'schedule_dto.freezed.dart';
part 'schedule_dto.g.dart';

@freezed
class ScheduleDTO with _$ScheduleDTO {
  const factory ScheduleDTO({
    // required String uid,
    @JsonKey(name: 'schedule_name') required String scheduleName,
    String? description,
    @JsonKey(name: 'is_time_set') required bool isTimeSet,
    @JsonKey(name: 'section_color') required int sectionColor,

    @JsonKey(name: 'from')
    @DatetimeConverter()
    required DateTime from,
    @JsonKey(name: 'to')
    @DatetimeConverter()
    required DateTime to,
  }) = _ScheduleDTO;

  factory ScheduleDTO.fromJson(Map<String, dynamic> json) => _$ScheduleDTOFromJson(json);
}