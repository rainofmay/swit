import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/domain/repositories/schedule_repository.dart';

class UpdateScheduleUseCase {
  final ScheduleRepository repository;
  UpdateScheduleUseCase(this.repository);

  Future updateSchedule(Schedule schedule) async {
    await repository.updateSchedule(schedule);
  }
}