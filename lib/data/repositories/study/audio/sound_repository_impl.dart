import 'package:swit/data/data_source/remote/study/audio/sound_remote_data_source.dart';
import 'package:swit/data/models/study/audio_dto.dart';
import 'package:swit/domain/repository/study/audio/sound_repository.dart';
import 'package:swit/domain/entities/study/audio/audio.dart';

class SoundRepositoryImpl implements SoundRepository {
  final SoundRemoteDataSource remoteDataSource;
  SoundRepositoryImpl(this.remoteDataSource);


  @override
  Future<List<Audio>> getSounds(String theme) async {
    try {
      final List<Map<String, dynamic>> rawData = await remoteDataSource.getSounds(theme);
      print('Raw data: $rawData'); // 원시 데이터 출력

      final List<AudioDTO> audioDTOs = [];
      for (var json in rawData) {
        try {
          audioDTOs.add(AudioDTO.fromJson(json));
        } catch (e) {
          print('Error parsing JSON: $json');
          print('Error details: $e');
        }
      }

      print('Parsed AudioDTOs: $audioDTOs');

      return audioDTOs.map((dto) => Audio(
        id: dto.id,
        name: dto.name,
        theme: dto.theme,
        audioUrl: dto.audioUrl,
      )).toList();
    } catch (e) {
      print('Exception in getSounds: $e');
      throw Exception('Failed to fetch sounds: $e');
    }
  }
}