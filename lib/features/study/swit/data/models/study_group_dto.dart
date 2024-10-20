import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_group_dto.freezed.dart';
part 'study_group_dto.g.dart';

@freezed
class StudyGroupDTO with _$StudyGroupDTO {
  const factory StudyGroupDTO({
    @JsonKey(name: 'group_id') required String groupId,
    required String name,
    String? description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'is_active') required bool isActive,
  }) = _StudyGroupDTO;

  factory StudyGroupDTO.fromJson(Map<String, dynamic> json) =>
      _$StudyGroupDTOFromJson(json);

}