import 'package:swit/domain/entities/study/audio/audio.dart';

abstract class SoundRepository {
  Future<List<Audio>> getSounds();
}