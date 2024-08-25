import 'package:swit/features/study/audio/data/datasources/music_remote_data_source.dart';
import 'package:swit/features/study/audio/data/models/audio_dto.dart';
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/domain/repositories/music_repository.dart';

class MusicRepositoryImpl implements MusicRepository{
  final MusicRemoteDataSource remoteDataSource;
  MusicRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Audio>> getMusics(String theme) async {
    try {
      final List<Map<String, dynamic>> rawData = await remoteDataSource.getMusics(theme);
      print('Raw data: $rawData'); // 원시 데이터 출력

      final List<AudioDTO> audioDTOs = [];
      for (var json in rawData) {
        try {
          audioDTOs.add(AudioDTO.fromJson(json));
        } catch (e) {
          print('Error music parsing JSON: $json');
        }
      }

      print('Parsed Music DTOs: $audioDTOs');

      return audioDTOs.map((dto) => Audio(
        id: dto.id,
        name: dto.name,
        theme: dto.theme,
        audioUrl: dto.audioUrl,
      )).toList();
    } catch (e) {
      print('Exception in getMusics: $e');
      throw Exception('Failed to fetch musics: $e');
    }
  }
}