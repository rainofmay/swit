// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioDTOImpl _$$AudioDTOImplFromJson(Map<String, dynamic> json) =>
    _$AudioDTOImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      theme: json['theme'] as String,
      audioUrl: json['audio_url'] as String,
    );

Map<String, dynamic> _$$AudioDTOImplToJson(_$AudioDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'theme': instance.theme,
      'audio_url': instance.audioUrl,
    };
