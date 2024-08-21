import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:swit/domain/entities/study/audio/audio.dart';
import 'package:swit/domain/entities/study/audio/audio_player_state.dart';

class AudioService {
  final Map<int, AudioPlayer> _players = {};
  final StreamController<AudioPlayerState> _stateController = StreamController<AudioPlayerState>.broadcast();

  Stream<AudioPlayerState> get playerStateStream => _stateController.stream;

  Future<void> play(Audio sound) async {
    if (!_players.containsKey(sound.id)) {
      final player = AudioPlayer();
      await player.setUrl(sound.audioUrl);
      _players[sound.id] = player;

      player.playerStateStream.listen((playerState) {
        _stateController.add(AudioPlayerState(soundId: sound.id, playerState: playerState));
      });
    }
    await _players[sound.id]!.play();
  }

  Future<void> pause(int soundId) async {
    await _players[soundId]?.pause();
  }

  Future<void> stop(int soundId) async {
    await _players[soundId]?.stop();
    await _players[soundId]?.dispose();
    _players.remove(soundId);
    _stateController.add(AudioPlayerState(
        soundId: soundId,
        playerState: PlayerState(false, ProcessingState.idle)
    ));
  }

  Future<void> setVolume(int soundId, double volume) async {
    await _players[soundId]?.setVolume(volume);
  }

  double getVolume(int soundId) {
    return _players[soundId]?.volume ?? 1.0;
  }

  bool isPlaying(int soundId) {
    return _players[soundId]?.playing ?? false;
  }

  void dispose() {
    for (var player in _players.values) {
      player.dispose();
    }
    _players.clear();
    _stateController.close();
  }
}