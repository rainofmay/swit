import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/domain/repositories/music_repository.dart';

class GetMusicUseCase {
  final MusicRepository repository;
  GetMusicUseCase(this.repository);

  Future<List<Audio>> getMusics(String theme) async {
    return await repository.getMusics(theme);
  }
}

