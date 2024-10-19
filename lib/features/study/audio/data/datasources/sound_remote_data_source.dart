

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/data/base_remote_datasource.dart';

class SoundRemoteDataSource extends BaseRemoteDataSource{

  Future<List<Map<String, dynamic>>> getSounds(String theme) async {
    try {
       final response = await supabase.from('sound').select().eq('theme', theme);
      return response;
    }
    catch (e) {
      throw Exception('Error DataSource getSounds: $e');
    }
  }
}