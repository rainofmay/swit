import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/utils/schedule/datetime_converter.dart';
import 'package:swit/features/study/schedule/data/models/schedule_dto.dart';

class ScheduleRemoteDataSource {
  ScheduleRemoteDataSource._internal();

  static final ScheduleRemoteDataSource _instance = ScheduleRemoteDataSource._internal();

  factory ScheduleRemoteDataSource() {
    return _instance;
  }

  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getSchedules() async {
    try {
      final response = await supabase
          .from('schedule')
          .select()
          .order('created_at', ascending: false);
      return response;
    } catch (e) {
      throw Exception('Error DataSource getSchedules: $e');
    }
  }

  Future createSchedule(ScheduleDTO dto) async {
    // if (_userId == null) throw Exception('User not authenticated');
    try {
      const converter = DatetimeConverter();
      await supabase.from('schedule').insert({
        'schedule_name': dto.scheduleName,
        'description': dto.description,
        'is_time_set': dto.isTimeSet,
        'section_color': dto.sectionColor,
        'from': converter.toJson(dto.from),
        'to': converter.toJson(dto.to),
      });
    } catch (error) {
      print('Schedule Add 에러 $error');
    }
  }
}
