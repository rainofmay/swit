import 'package:swit/features/study/audio/sound/domain/entities/audio.dart';

abstract class SoundRepository {
  Future<List<Audio>> getSounds(String theme);
}