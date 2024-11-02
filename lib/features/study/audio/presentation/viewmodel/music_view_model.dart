import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/domain/usecases/get_music_use_case.dart';

class MusicViewModel extends GetxController {
  final GetMusicUseCase _useCase;
  final AudioHandler _audioHandler;

  MusicViewModel({
    required GetMusicUseCase useCase,
    required AudioHandler audioHandler,
  })  : _useCase = useCase,
        _audioHandler = audioHandler;

  final RxList<Audio> _musicList = <Audio>[].obs;
  final RxBool _isLoading = true.obs;
  final RxBool _isMusicPlaying = false.obs;
  final RxBool _isShuffled = false.obs;
  final RxBool _isRepeated = false.obs;
  final RxInt _currentIndex = 0.obs;
  final Rx<Duration> _currentMusicDuration = Duration.zero.obs;
  final Rx<Duration> _currentMusicPosition = Duration.zero.obs;

  bool get isShuffled => _isShuffled.value;
  bool get isLoading => _isLoading.value;
  bool get isMusicPlaying => _isMusicPlaying.value;
  bool get isRepeated => _isRepeated.value;
  Duration get currentMusicDuration => _currentMusicDuration.value;
  Duration get currentMusicPosition => _currentMusicPosition.value;
  Audio get currentMusic => _musicList[_currentIndex.value];

  @override
  void onInit() {
    super.onInit();
    _loadMusics();
    _setupAudioHandlerListeners();
  }

  /* ------------------------------------------------------ */
  /* Init & Get ------------------------------------------- */
  /* ------------------------------------------------------ */
  Future<void> _loadMusics() async {
    _isLoading.value = true;
    try {
      final result = await _useCase.getMusics('study');
      _musicList.assignAll(result);

      // 실질적인 재생리스트 및 플레이어 초기화
      await _updateQueue();
      _isLoading.value = false;
    } catch (e) {
      print('Error loading musics: $e');
      _isLoading.value = false;
    }
  }

  void _setupAudioHandlerListeners() {
    _audioHandler.playbackState.listen((playbackState) {
      _isMusicPlaying.value = playbackState.playing;
      _currentMusicPosition.value = playbackState.position;
      _isShuffled.value = playbackState.shuffleMode == AudioServiceShuffleMode.all;
      _isRepeated.value = playbackState.repeatMode != AudioServiceRepeatMode.none;
    });

    _audioHandler.mediaItem.listen((mediaItem) {
      if (mediaItem != null) {
        _currentIndex.value = _musicList.indexWhere((audio) => audio.audioUrl == mediaItem.id);
        _currentMusicDuration.value = mediaItem.duration ?? Duration.zero;
      }
    });
  }

  /* ------------------------------------------------------ */
  /* Update ----------------------------------------------- */
  /* ------------------------------------------------------ */

  Future<void> _updateQueue() async {
    final mediaItems = _musicList.map((audio) => MediaItem(
      id: audio.audioUrl,
      album: audio.theme,
      title: audio.name,
      artist: "Swit",
      extras: {'url': audio.audioUrl},
    )).toList();

    await _audioHandler.addQueueItems(mediaItems);
  }


  /* ------------------------------------------------------ */
  /* Control ---------------------------------------------- */
  /* ------------------------------------------------------ */
  Future<void> musicPlayPause() async {
    if (_isMusicPlaying.value) {
      await _audioHandler.pause();
    } else {
      await _audioHandler.play();
    }
  }

  Future<void> nextTrack() => _audioHandler.skipToNext();

  Future<void> previousTrack() => _audioHandler.skipToPrevious();

  void toggleShuffle() {
    final newMode = _isShuffled.value ? AudioServiceShuffleMode.none : AudioServiceShuffleMode.all;
    _isShuffled.value = !_isShuffled.value; // 즉시 상태 업데이트
    _audioHandler.setShuffleMode(newMode);

  }

  void toggleRepeat() {
    final newMode = _isRepeated.value ? AudioServiceRepeatMode.none : AudioServiceRepeatMode.all;
    _isRepeated.value = !_isRepeated.value; // 즉시 상태 업데이트
    _audioHandler.setRepeatMode(newMode);
  }

  Future<void> seekTo(double value) async {
    final position = Duration(milliseconds: (value / 100 * _currentMusicDuration.value.inMilliseconds).round());
    await _audioHandler.seek(position);
  }
}