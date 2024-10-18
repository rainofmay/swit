

import 'package:supabase_flutter/supabase_flutter.dart';

class SoundRemoteDataSource {
  SoundRemoteDataSource._internal();
  // _instance : SoundRemoteDataSource의 유일한 인스턴스를 저장
  static final SoundRemoteDataSource _instance = SoundRemoteDataSource._internal();
  factory SoundRemoteDataSource() => _instance;

  final supabase = Supabase.instance.client;

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