import 'package:supabase_flutter/supabase_flutter.dart';

class ScheduleRemoteDataSource {
  ScheduleRemoteDataSource._internal();

  static final ScheduleRemoteDataSource _instance = ScheduleRemoteDataSource._internal();

  factory ScheduleRemoteDataSource() {
    return _instance;
  }

  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getSchedules(String theme) async {
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
}