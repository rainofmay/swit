import 'package:just_audio/just_audio.dart';

class AudioPlayerState {
  final int soundId;
  final PlayerState playerState;

  AudioPlayerState({required this.soundId, required this.playerState});

  bool get isPlaying => playerState.playing;

  // 현재 처리상태 : 로딩, 버퍼링, 재생준비, 재생완료
  ProcessingState get processingState => playerState.processingState;
}