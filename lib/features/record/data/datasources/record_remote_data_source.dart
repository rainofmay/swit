import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/features/record/data/models/record_time_dto.dart';

class RecordRemoteDataSource {
  RecordRemoteDataSource._internal();

  static final RecordRemoteDataSource _instance =
      RecordRemoteDataSource._internal();

  factory RecordRemoteDataSource() {
    return _instance;
  }

  final _supabase = Supabase.instance.client;

  Future<void> createRecord(RecordTimeDTO dto) async {
    try {
      // 오늘 날짜의 기록 확인
      final existingRecord = await _supabase
          .from('record')
          .select()
          .eq('date', dto.date)
          .eq('task_id', dto.taskId)
          .maybeSingle();

      if (existingRecord != null) {
        // 기존 기록이 있으면 공부 시간, 공부 내용 업데이트
        await _supabase
            .from('record')
            .update({
              'record_time': dto.recordTime,
               'contents': dto.contents,
            })
            .eq('date', dto.date)
            .eq('task_id', dto.taskId);
      } else {
        // 새 레코드 삽입
        await _supabase.from('record').insert({
          'date': dto.date,
          'task_id': dto.taskId,
          'record_time': dto.recordTime,
          'contents': dto.contents
        });
      }
    } catch (e) {
      throw Exception('Remote DataSource Failed to create record: $e');
    }
  }
}
