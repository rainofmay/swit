import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/data/base_remote_datasource.dart';

class MusicRemoteDataSource extends BaseRemoteDataSource{
  
  Future<List<Map<String, dynamic>>> getMusics(String theme) async {
    try {
      final response = await supabase.from('music').select().eq('theme', theme);
      return response;
    } catch (e) {
      throw Exception('Error DataSource getMusics: $e');
    }
  }
}

