import 'package:swit/core/utils/swit/group_invitation_mapper.dart';
import 'package:swit/core/utils/swit/study_group_mapper.dart';
import 'package:swit/features/study/swit/data/datasources/study_group_reomote_data_source.dart';
import 'package:swit/features/study/swit/data/models/group_invitation_dto.dart';
import 'package:swit/features/study/swit/data/models/study_group_dto.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';
import 'package:swit/features/study/swit/domain/entities/study_group.dart';
import 'package:swit/features/study/swit/domain/repositories/study_group_repository.dart';

class StudyGroupRepositoryImpl implements StudyGroupRepository {
  final StudyGroupRemoteDataSource remoteDataSource;

  StudyGroupRepositoryImpl(this.remoteDataSource);

  @override
  Future<StudyGroup> createStudyGroup(String name, String description) async {
    try {
      final Map<String, dynamic> rawData = await remoteDataSource.createStudyGroup(name, description);
      return StudyGroupMapper.toEntity(StudyGroupDTO.fromJson(rawData));
    } catch (e) {
      print('StudyGroupRepositoryImpl createStudyGroup Error: $e');
      throw Exception('Failed to create study group: $e');
    }
  }

  @override
  Future<GroupInvitation> inviteToGroup(String groupId, String invitedUserId) async {
    try {
      final rawData = await remoteDataSource.inviteToGroup(groupId, invitedUserId);
      final dto = GroupInvitationDTO.fromJson(rawData);
      return GroupInvitationMapper.fromDto(dto);
    } catch (e) {
      print('StudyGroupRepositoryImpl inviteToGroup Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> hasExistingGroup() async {
    return await remoteDataSource.hasExistingGroup();
  }
}