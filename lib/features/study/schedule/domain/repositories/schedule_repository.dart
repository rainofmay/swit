import 'package:swit/features/study/schedule/data/models/schedule_dto.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';

abstract class ScheduleRepository {
  Future<List<Schedule>> getSchedules();

  Future createSchedule(Schedule schedule);

  Future updateSchedule(Schedule schedule);

  Future deleteSchedule(Schedule schedule);
}