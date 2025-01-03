
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/domain/repositories/sound_repository.dart';

class GetSoundUseCase {
  final SoundRepository repository;
  GetSoundUseCase(this.repository);

  Future<List<Audio>> execute(String theme) async {
    return await repository.getSounds(theme);
  }
}

