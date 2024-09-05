import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/domain/repositories/schedule_repository.dart';

class GetScheduleUseCase {
  final ScheduleRepository repository;
  GetScheduleUseCase(this.repository);

  Future<List<Schedule>> getSchedules() async {
    return await repository.getSchedules();
  }
}