import 'package:swit/features/study/swit/data/datasources/study_group_reomote_data_source.dart';
import 'package:swit/features/study/swit/domain/repositories/study_group_repository.dart';

class StudyGroupRepositoryImpl implements StudyGroupRepository {
  final StudyGroupRemoteDataSource remoteDataSource;

  StudyGroupRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createStudyGroup() async {
    try {
      await remoteDataSource.createStudyGroup();
    } catch (e) {
      print('StudyGroupRepositoryImpl createStudyGroup Error : $e');
    }
  }

  @override
  Future<void> inviteToGroup(String groupId, String invitedUserId) async {
    try {
      await remoteDataSource.inviteToGroup(groupId, invitedUserId);
    } catch (e) {
      print('StudyGroupRepositoryImpl inviteToGroup Error : $e');
    }
  }
}