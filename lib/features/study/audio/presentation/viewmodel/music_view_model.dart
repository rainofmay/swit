import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:swit/core/utils/audio_service.dart';
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/domain/usecases/get_music_use_case.dart';

class MusicViewModel extends GetxController {
  final GetMusicUseCase _useCase;
  final AudioService _audioService;

  MusicViewModel({
    required GetMusicUseCase useCase,
    required AudioService audioService,
  })
      : _useCase = useCase,
        _audioService = audioService;

  late final Rx<AudioPlayer> _musicPlayer = AudioPlayer().obs;
  late final RxList<Audio> _musicList = <Audio>[].obs;

  late final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  late final RxBool _isMusicPlaying = false.obs;
  bool get isMusicPlaying => _isMusicPlaying.value;

  final RxBool isShuffled = false.obs;
  late final RxBool _isRepeated = false.obs;
  bool get isRepeated => _isRepeated.value;
  late final RxInt _currentIndex = 0.obs;

  late final Rx<Duration> _currentMusicDuration = Duration.zero.obs;
  Duration get currentMusicDuration => _currentMusicDuration.value;
  late final Rx<Duration> _currentMusicPosition = Duration.zero.obs;
  Duration get currentMusicPosition => _currentMusicPosition.value;

  Audio get currentMusic => _musicList[_currentIndex.value];

  @override
  void onInit() {
    super.onInit();
    _loadMusics();
    _initAudioPlayer();
  }

  @override
  void onClose() {
    _musicPlayer.value.dispose();
    super.onClose();
  }

  /* --- init --- */

  // 재생리스트 초기화
  Future<void> _loadMusics() async {
    _isLoading.value = true;
    try {
      final result = await _useCase.execute('study');
      _musicList.assignAll(result);
      _isLoading.value = false;
    } catch (e) {
      print('Error loading musics: $e');
      _isLoading.value = false;
    }
  }

  void _initAudioPlayer() {
    _musicPlayer.value = AudioPlayer(
      handleInterruptions: false, // 오디오 포커스 자동 관리 비활성화를 통해 소리, 음악 둘다 재생 가능하게.
    );
    _setupPlayerListeners();
  }

  void _setupPlayerListeners() {
    _musicPlayer.value.playerStateStream.listen((state) {
      _isMusicPlaying.value = state.playing;
    });
    _musicPlayer.value.positionStream.listen((position) {
      _currentMusicPosition.value = position;
    });
    _musicPlayer.value.durationStream.listen((duration) {
      _currentMusicDuration.value = duration ?? Duration.zero;
    });

    // Listen to changes in current playing track
    _musicPlayer.value.currentIndexStream.listen((index) {
      if (index != null && index != _currentIndex.value) {
        _currentIndex.value = index;
        // _updateCurrentMediaItem();
        update(); // Trigger UI update
      }
    });

    // Listen to changes in _musicInfoList and update background playback
    // ever(_musicInfoList, (_) => _setupBackgroundPlayback());
  }


  /* --- Functions --- */
  Future<void> musicPlayPause() async {
    if (_musicPlayer.value.playing) {
      await _musicPlayer.value.pause();
      _isMusicPlaying.value = false;
    } else {
      if (_currentMusicPosition.value > Duration.zero) {
        await _musicPlayer.value.play();
        _isMusicPlaying.value = true;
      } else {
        await _playCurrentTrack();
      }
    }
  }

  Future<void> _playCurrentTrack() async {
    final url = _musicList[_currentIndex.value].audioUrl;
    await _musicPlayer.value.setUrl(url);
    _musicPlayer.value.play();
  }

  void nextTrack() {
    if (_currentIndex.value < _musicList.length - 1) {
      _currentIndex.value++;
    } else {
      _currentIndex.value = 0;
    }
    _playCurrentTrack();
  }

  void previousTrack() {
    if (_currentIndex.value > 0) {
      _currentIndex.value--;
    } else {
      _currentIndex.value = _musicList.length - 1;
    }
    _playCurrentTrack();
  }

  void toggleShuffle() {
    isShuffled.value = !isShuffled.value;
    _musicPlayer.value.setShuffleModeEnabled(isShuffled.value);
  }

  void toggleRepeat() {
    _isRepeated.value = !_isRepeated.value;
    _musicPlayer.value.setLoopMode(_isRepeated.value ? LoopMode.one : LoopMode.off);
  }

  Future<void> seekTo(double value) async {
    final position = Duration(milliseconds: (value / 100 * _currentMusicDuration.value.inMilliseconds).round());
    await _musicPlayer.value.seek(position);
  }
}