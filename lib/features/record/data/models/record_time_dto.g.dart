// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_time_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordTimeDTOImpl _$$RecordTimeDTOImplFromJson(Map<String, dynamic> json) =>
    _$RecordTimeDTOImpl(
      taskId: json['taskId'] as String,
      date: json['date'] as String,
      recordTime: (json['recordTime'] as num).toInt(),
      contents: json['contents'] as String?,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$RecordTimeDTOImplToJson(_$RecordTimeDTOImpl instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'date': instance.date,
      'recordTime': instance.recordTime,
      'contents': instance.contents,
      'title': instance.title,
    };
