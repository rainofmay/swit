// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleDTOImpl _$$ScheduleDTOImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleDTOImpl(
      scheduleName: json['schedule_name'] as String,
      description: json['description'] as String?,
      isTimeSet: json['is_time_set'] as bool,
      sectionColor: (json['section_color'] as num).toInt(),
      from: const DatetimeConverter().fromJson(json['from'] as String),
      to: const DatetimeConverter().fromJson(json['to'] as String),
    );

Map<String, dynamic> _$$ScheduleDTOImplToJson(_$ScheduleDTOImpl instance) =>
    <String, dynamic>{
      'schedule_name': instance.scheduleName,
      'description': instance.description,
      'is_time_set': instance.isTimeSet,
      'section_color': instance.sectionColor,
      'from': const DatetimeConverter().toJson(instance.from),
      'to': const DatetimeConverter().toJson(instance.to),
    };
