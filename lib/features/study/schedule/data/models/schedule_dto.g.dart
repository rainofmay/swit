// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleDTOImpl _$$ScheduleDTOImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleDTOImpl(
      id: json['id'] as String,
      scheduleName: json['schedule_name'] as String,
      description: json['description'] as String,
      isAllDay: json['is_all_day'] as bool,
      sectionColor: (json['section_color'] as num).toInt(),
      from: const DatetimeConverter().fromJson(json['from'] as String),
      to: const DatetimeConverter().fromJson(json['to'] as String),
    );

Map<String, dynamic> _$$ScheduleDTOImplToJson(_$ScheduleDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schedule_name': instance.scheduleName,
      'description': instance.description,
      'is_all_day': instance.isAllDay,
      'section_color': instance.sectionColor,
      'from': const DatetimeConverter().toJson(instance.from),
      'to': const DatetimeConverter().toJson(instance.to),
    };
