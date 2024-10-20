import 'package:swit/features/study/swit/data/models/study_group_dto.dart';
import 'package:swit/features/study/swit/domain/entities/study_group.dart';

class StudyGroupMapper {
  static StudyGroup toEntity(StudyGroupDTO dto) {
    return StudyGroup(
      groupId: dto.groupId,
      name: dto.name,
      description: dto.description ?? '',
      createdAt: dto.createdAt,
      createdBy: dto.createdBy,
      isActive: dto.isActive,
    );
  }

  static StudyGroupDTO toDto(StudyGroup entity) {
    return StudyGroupDTO(
      groupId: entity.groupId,
      name: entity.name,
      description: entity.description,
      createdAt: entity.createdAt,
      createdBy: entity.createdBy,
      isActive: entity.isActive,
    );
  }
}