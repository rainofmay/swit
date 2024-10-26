import 'package:swit/core/data/base_remote_datasource.dart';

class NotificationRemoteDataSource extends BaseRemoteDataSource {
  Future<List<Map<String, dynamic>>> getNotifications() async {
    try {
      final response = await supabase
          .from('notifications')
          .select()
          .eq('receiver_id', supabase.auth.currentUser!.id)
          .order('created_at', ascending: false); // 최신순 정렬

      print('notification $response');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Error DataSource getNotifications: $e');
    }
  }
}
