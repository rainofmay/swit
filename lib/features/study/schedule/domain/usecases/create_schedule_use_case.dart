import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/domain/repositories/schedule_repository.dart';

class CreateScheduleUseCase {
  final ScheduleRepository repository;
  CreateScheduleUseCase(this.repository);

  Future<List<Schedule>> createSchedule(Schedule schedule) async {
    return await repository.createSchedule(schedule);
  }
}