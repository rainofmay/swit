// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyGroupDTOImpl _$$StudyGroupDTOImplFromJson(Map<String, dynamic> json) =>
    _$StudyGroupDTOImpl(
      groupId: json['group_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$$StudyGroupDTOImplToJson(_$StudyGroupDTOImpl instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'is_active': instance.isActive,
    };
