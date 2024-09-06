import 'package:swit/core/utils/schedule/schedule_mapper.dart';
import 'package:swit/features/study/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:swit/features/study/schedule/data/models/schedule_dto.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/domain/repositories/schedule_repository.dart';
import 'package:swit/shared/constant/schedule_color.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Schedule>> getSchedules() async {
    try {
      final List<Map<String, dynamic>> rawData = await remoteDataSource.getSchedules();
      print('Schedule Raw data: $rawData'); // 원시 데이터 출력

      return rawData.map((json) {
        try {
          final dto = ScheduleDTO.fromJson(json);
          return ScheduleMapper.toEntity(dto);
        } catch (e) {
          print('Error parsing Schedule JSON: $json');
          print('Error details: $e');
          return null;
        }
      }).whereType<Schedule>().toList();

    } catch (e) {
      throw Exception('Failed to fetch Schedules: $e');
    }
  }

  @override
  Future createSchedule(Schedule schedule) async {
    try {
      final dto = ScheduleMapper.toDTO(schedule);
      await remoteDataSource.createSchedule(dto);

    } catch (e) {
      throw Exception('Failed to create Schedule repository: $e');
    }
  }
}