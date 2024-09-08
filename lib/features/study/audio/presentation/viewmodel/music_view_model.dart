import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/domain/usecases/get_music_use_case.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MusicViewModel extends GetxController {
  final GetMusicUseCase _useCase;

  MusicViewModel({required GetMusicUseCase useCase}) : _useCase = useCase;

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

  /* -- music background -- */
  late final Rx<MediaItem?> _currentMediaItem = Rx<MediaItem?>(null);
  MediaItem? get currentMediaItem => _currentMediaItem.value;

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

  /* --- Init & Get --- */
  void _initAudioPlayer() {
    _musicPlayer.value = AudioPlayer(
      handleInterruptions: false, // 오디오 포커스 자동 관리 비활성화를 통해 소리, 음악 둘다 재생 가능하게.
      androidApplyAudioAttributes: false,
      handleAudioSessionActivation: false,
    );
    _setupPlayerListeners();
  }

  //assetPath에서 추출 후에, Uri 형태로 사용하기 위해서 만든 구조
  Future<Uri> _getAssetUri(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final buffer = byteData.buffer;
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${assetPath.split('/').last}');
    await tempFile.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return Uri.file(tempFile.path);
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
        _updateCurrentMediaItem();
        update(); // Trigger UI update
      }
    });

    // Listen to changes in _musicInfoList and update background playback
    ever(_musicList, (_) => _setupBackgroundPlayback());
  }

  Future<void> _setupBackgroundPlayback() async {
    if (_musicList.isEmpty) return;

    final audioSources = await Future.wait(_musicList.map((music) async {
      final artUri = await _getAssetUri('assets/images/music/music_background.png');
      return AudioSource.uri(
        Uri.parse(music.audioUrl),
        tag: MediaItem(
          id: music.audioUrl,
          album: music.theme,
          title: music.name,
          artist: "Swit",
          artUri: artUri,
        ),
      );
    }));

    await _musicPlayer.value.setAudioSource(
      ConcatenatingAudioSource(children: audioSources),
      initialIndex: _currentIndex.value,
      preload: false,
    );
  }

  /* --- Update --- */

  // 백그라운드 현재 음악 설정을 위한 함수
  void _updateCurrentMediaItem() async {
    if (_musicList.isNotEmpty &&
        _currentIndex.value < _musicList.length) {
      final currentMusic = _musicList[_currentIndex.value];
      final artUri = await _getAssetUri('assets/images/music/music_background.png');
      _currentMediaItem.value = MediaItem(
        id: currentMusic.audioUrl,
        album: currentMusic.theme,
        title: currentMusic.name,
        artist: "Swit",
        duration: _currentMusicDuration.value,
        artUri: artUri,
      );
    }
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
    _musicPlayer.value
        .setLoopMode(_isRepeated.value ? LoopMode.one : LoopMode.off);
  }

  Future<void> seekTo(double value) async {
    final position = Duration(
        milliseconds:
            (value / 100 * _currentMusicDuration.value.inMilliseconds).round());
    await _musicPlayer.value.seek(position);
  }
}
