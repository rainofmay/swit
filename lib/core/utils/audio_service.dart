import 'package:just_audio/just_audio.dart';

class AudioService {
  Future<AudioPlayer> createPlayer(String url) async {
    try {
      final player = AudioPlayer();
      await player.setUrl(url);
      // await player.setAsset(url);
      return player;
    } catch (e) {
      print('Error creating audio player: $e');
      rethrow;
    }
  }

  Future<void> play(AudioPlayer player) async {
    try {
      await player.play();
    } catch (e) {
      print('Error playing audio: $e');
      rethrow;
    }
  }

  Future<void> pause(AudioPlayer player) async {
    try {
      await player.pause();
    } catch (e) {
      print('Error pausing audio: $e');
      rethrow;
    }
  }

  Future<void> stop(AudioPlayer player) async {
    try {
      await player.stop();
    } catch (e) {
      print('Error stopping audio: $e');
      rethrow;
    }
  }

  Future<void> setVolume(AudioPlayer player, double volume) async {
    try {
      await player.setVolume(volume);
    } catch (e) {
      print('Error setting volume: $e');
      rethrow;
    }
  }

  Future<void> seekTo(AudioPlayer player, Duration position) async {
    try {
      await player.seek(position);
    } catch (e) {
      print('Error seeking audio: $e');
      rethrow;
    }
  }

  Future<void> setLoopMode(AudioPlayer player, LoopMode mode) async {
    try {
      await player.setLoopMode(mode);
    } catch (e) {
      print('Error setting loop mode: $e');
      rethrow;
    }
  }

  Future<void> dispose(AudioPlayer player) async {
    try {
      await player.dispose();
    } catch (e) {
      print('Error disposing audio player: $e');
      rethrow;
    }
  }
}