// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordInfoDTOImpl _$$RecordInfoDTOImplFromJson(Map<String, dynamic> json) =>
    _$RecordInfoDTOImpl(
      id: json['id'] as String,
      date: json['date'] as String,
      recordTime: (json['recordTime'] as num).toInt(),
      contents: json['contents'] as String?,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$RecordInfoDTOImplToJson(_$RecordInfoDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'recordTime': instance.recordTime,
      'contents': instance.contents,
      'title': instance.title,
    };
