import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_group_dto.freezed.dart';
part 'study_group_dto.g.dart';

@freezed
class StudyGroupDTO with _$StudyGroupDTO {
  const factory StudyGroupDTO({
    required String groupId,
    required String name,
    String? description,
    required DateTime createdAt,
    required String createdById,
    required bool isActive,
  }) = _StudyGroupDTO;

  factory StudyGroupDTO.fromJson(Map<String, dynamic> json) =>
      _$StudyGroupDTOFromJson(json);

}