// Mappers
import 'package:swit/features/study/swit/data/models/group_invitation_dto.dart';
import 'package:swit/features/study/swit/data/models/study_group_dto.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';
import 'package:swit/features/study/swit/domain/entities/study_group.dart';

class StudyGroupMapper {
  static StudyGroup fromDto(StudyGroupDTO dto) {
    return StudyGroup(
      groupId: dto.groupId,
      name: dto.name,
      description: dto.description,
      createdAt: dto.createdAt,
      createdById: dto.createdById,
      isActive: dto.isActive,
    );
  }
}