import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/domain/repositories/schedule_repository.dart';

class DeleteScheduleUseCase {
  final ScheduleRepository repository;
  DeleteScheduleUseCase(this.repository);

  Future execute(Schedule schedule) async {
    await repository.deleteSchedule(schedule);
  }
}