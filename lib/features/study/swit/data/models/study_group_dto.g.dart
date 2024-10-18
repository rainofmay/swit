// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyGroupDTOImpl _$$StudyGroupDTOImplFromJson(Map<String, dynamic> json) =>
    _$StudyGroupDTOImpl(
      groupId: json['groupId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdById: json['createdById'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$$StudyGroupDTOImplToJson(_$StudyGroupDTOImpl instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdById': instance.createdById,
      'isActive': instance.isActive,
    };
