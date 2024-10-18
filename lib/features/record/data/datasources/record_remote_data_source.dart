import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/features/record/data/models/record_info_dto.dart';

class RecordRemoteDataSource {
  RecordRemoteDataSource._internal();

  static final RecordRemoteDataSource _instance =
      RecordRemoteDataSource._internal();

  factory RecordRemoteDataSource() => _instance;

  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getRecords() async {
    try {
      final response = await _supabase
          .from('record')
          .select('*')
          .order('created_at', ascending:true);

      return response;
    } catch (e) {
      throw Exception('Remote DataSource Failed to get records: $e');
    }
  }

  Future<void> createRecord(RecordInfoDTO dto) async {
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
          'id': dto.id,
          'task_id': dto.taskId,
          'title': dto.title,
          'record_time': dto.recordTime,
          'contents': dto.contents
        });
      }
    } catch (e) {
      throw Exception('Remote DataSource Failed to create record: $e');
    }
  }

  Future<void> updateRecord(String id, String newContents) async {
    try {
      await _supabase
          .from('record')
          .update({'contents': newContents}).eq('id', id);
    } catch (e) {
      throw Exception('Remote DataSource Failed to update record: $e');
    }
  }

  Future<void> deleteRecord(String id) async {
    try {
      await _supabase.from('record').delete().eq('id', id);
    } catch (e) {
      throw Exception('Remote DataSource Failed to delete record: $e');
    }
  }
}
