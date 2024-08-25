import 'package:swit/features/study/audio/domain/entities/audio.dart';

abstract class MusicRepository {
  Future<List<Audio>> getMusics(String theme);
}