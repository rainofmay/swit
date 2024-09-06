import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swit/core/utils/schedule/datetime_converter.dart';

part 'schedule_dto.freezed.dart';
part 'schedule_dto.g.dart';

@freezed
class ScheduleDTO with _$ScheduleDTO {
  const factory ScheduleDTO({
    // required String uid,
    required String id,
    @JsonKey(name: 'schedule_name') required String scheduleName,
    required String description,
    @JsonKey(name: 'is_all_day') required bool isAllDay,
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