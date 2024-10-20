import 'package:swit/features/study/swit/domain/entities/study_group.dart';
import 'package:swit/features/study/swit/domain/repositories/study_group_repository.dart';

class CreateStudyGroupUseCase {
  final StudyGroupRepository repository;
  CreateStudyGroupUseCase(this.repository);

  Future<StudyGroup> execute(String name, String description) async {
    return await repository.createStudyGroup(name, description);
  }
}