import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.cled.swit.audio',
      androidNotificationChannelName: 'Swit',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler {
  final _musicPlayer = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: []);
  final Map<int, AudioPlayer> _soundPlayers = {};
  final Map<int, bool> _soundPlayingStates = {};
  bool _isMusicPlaying = false;

  MyAudioHandler() {
    _loadEmptyPlaylist();
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
    _listenForCurrentSongIndexChanges();
    _listenForSequenceStateChanges();
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _musicPlayer.setAudioSource(_playlist);
    } catch (e) {
      print("Error: $e");
    }
  }

  // 오디오 플레이어의 재생 이벤트를 감지
  // 재생/일시정지, 이전/다음 트랙 건너뛰기, 정지 등의 컨트롤 상태를 설정
  void _notifyAudioHandlerAboutPlaybackEvents() {
    _musicPlayer.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _musicPlayer.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_musicPlayer.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[_musicPlayer.loopMode]!,
        shuffleMode: (_musicPlayer.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: _musicPlayer.position,
        bufferedPosition: _musicPlayer.bufferedPosition,
        speed: _musicPlayer.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  void _listenForDurationChanges() {
    _musicPlayer.durationStream.listen((duration) {
      var index = _musicPlayer.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      if (_musicPlayer.shuffleModeEnabled) {
        index = _musicPlayer.shuffleIndices!.indexOf(index);
      }
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  // 현재 재생 중인 트랙의 인덱스 변경을 감지합니다.
  // 셔플 모드를 고려하여 올바른 MediaItem을 선택하고 업데이트
  void _listenForCurrentSongIndexChanges() {
    _musicPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      if (_musicPlayer.shuffleModeEnabled) {
        index = _musicPlayer.shuffleIndices!.indexOf(index);
      }
      mediaItem.add(playlist[index]);
    });
  }

  // 재생 목록의 순서나 구조 변경을 감지
  // 변경된 순서에 따라 새로운 재생 목록(queue)을 생성하고 업데이트
  void _listenForSequenceStateChanges() {
    _musicPlayer.sequenceStateStream.listen((SequenceState? sequenceState) {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
      final items = sequence.map((source) => source.tag as MediaItem);
      queue.add(items.toList());
    });
  }

  // 사운드 관련 메서드
  Future<void> initializeSoundPlayer(int soundId, String url) async {
    _soundPlayers[soundId] = AudioPlayer();
    await _soundPlayers[soundId]!.setUrl(url);
    await _soundPlayers[soundId]!.setLoopMode(LoopMode.all); // 무한 반복 설정
    _soundPlayingStates[soundId] = false;
  }

  Future<void> playSoundTrack(int soundId) async {
    if (_soundPlayers.containsKey(soundId)) {
      await _soundPlayers[soundId]!.play();
      _soundPlayingStates[soundId] = true;

    }
  }

  Future<void> pauseSoundTrack(int soundId) async {
    if (_soundPlayers.containsKey(soundId)) {
      await _soundPlayers[soundId]!.pause();
      _soundPlayingStates[soundId] = false;

    }
  }

  Future<void> stopSoundTrack(int soundId) async {
    if (_soundPlayers.containsKey(soundId)) {
      await _soundPlayers[soundId]!.stop();
      await _soundPlayers[soundId]!.seek(Duration.zero); // 정지 후 시작 위치로 되돌림
      _soundPlayingStates[soundId] = false;
      _updatePlaybackState();
    }
  }

  Future<void> setSoundVolume(int soundId, double volume) async {
    if (_soundPlayers.containsKey(soundId)) {
      await _soundPlayers[soundId]!.setVolume(volume);
    }
  }

  void _updatePlaybackState() {
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        _isMusicPlaying ? MediaControl.pause : MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_musicPlayer.processingState]!,
      playing: _isMusicPlaying,
      updatePosition: _musicPlayer.position,
      bufferedPosition: _musicPlayer.bufferedPosition,
      speed: _musicPlayer.speed,
      queueIndex: _musicPlayer.currentIndex,
    ));
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // manage Just Audio
    final audioSource = mediaItems.map(_createAudioSource);
    _playlist.addAll(audioSource.toList());

    // notify system
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    // manage Just Audio
    final audioSource = _createAudioSource(mediaItem);
    _playlist.add(audioSource);

    // notify system
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras!['url'] as String),
      tag: mediaItem,
    );
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    // manage Just Audio
    _playlist.removeAt(index);

    // notify system
    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  @override
  Future<void> play() async {
    await _musicPlayer.play();
    _isMusicPlaying = true;
    _updatePlaybackState();
  }

  @override
  Future<void> pause() async {
    await _musicPlayer.pause();
    _isMusicPlaying = false;
    _updatePlaybackState();
  }

  @override
  Future<void> seek(Duration position) => _musicPlayer.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    if (_musicPlayer.shuffleModeEnabled) {
      index = _musicPlayer.shuffleIndices![index];
    }
    _musicPlayer.seek(Duration.zero, index: index);
  }

  @override
  Future<void> skipToNext() => _musicPlayer.seekToNext();

  @override
  Future<void> skipToPrevious() => _musicPlayer.seekToPrevious();

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _musicPlayer.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _musicPlayer.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
      _musicPlayer.setLoopMode(LoopMode.all);
        break;
    }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      _musicPlayer.setShuffleModeEnabled(false);
    } else {
      await _musicPlayer.shuffle();
      _musicPlayer.setShuffleModeEnabled(true);
    }
  }

  @override
  Future<void> customAction(String name, [Map<String, dynamic>? extras]) async {
    switch (name) {
      case 'initializeSoundPlayer':
        await initializeSoundPlayer(extras!['soundId'], extras['url']);
        break;
      case 'playSoundTrack':
        await playSoundTrack(extras!['soundId']);
        break;
      case 'pauseSoundTrack':
        await pauseSoundTrack(extras!['soundId']);
        break;
      case 'stopSoundTrack':
        await stopSoundTrack(extras!['soundId']);
        break;
      case 'setSoundVolume':
        await setSoundVolume(extras!['soundId'], extras['volume']);
        break;
      case 'dispose':
        await _musicPlayer.dispose();
        for (var player in _soundPlayers.values) {
          await player.dispose();
        }
        super.stop();
        break;
      default:
        await super.customAction(name, extras);
    }
  }

  @override
  Future<void> stop() async {
    await _musicPlayer.stop();
    for (var player in _soundPlayers.values) {
      await player.stop();
    }
    _soundPlayingStates.updateAll((key, value) => false);
    return super.stop();
  }
}