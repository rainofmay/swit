import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MusicRemoteDataSource {

  MusicRemoteDataSource._internal();

  static final MusicRemoteDataSource _instance = MusicRemoteDataSource._internal();

  factory MusicRemoteDataSource() {
    return _instance;
  }

  final supabase = Supabase.instance.client;
  
  Future<List<Map<String, dynamic>>> getMusics(String theme) async {
    try {
      final response = await supabase.from('music').select().eq('theme', theme);
      return response;
    } catch (e) {
      throw Exception('Error DataSource getMusics: $e');
    }
  }
}

