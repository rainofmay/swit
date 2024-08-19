
import 'package:swit/domain/entities/study/audio/audio.dart';
import 'package:swit/domain/repository/study/audio/sound_repository.dart';

class GetSoundUseCase {
  final SoundRepository repository;
  GetSoundUseCase(this.repository);

  Future<List<Audio>> execute() async {
    return await repository.getSounds();
  }
}