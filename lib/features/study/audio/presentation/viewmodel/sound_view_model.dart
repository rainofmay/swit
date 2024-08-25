import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:swit/core/utils/audio_service.dart';
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/domain/usecases/get_sound_use_case.dart';

class SoundViewModel extends GetxController {
  final GetSoundUseCase _useCase;
  final AudioService _audioService;

  SoundViewModel({
    required GetSoundUseCase useCase,
    required AudioService audioService,
  })  : _useCase = useCase,
        _audioService = audioService;

  final RxList<Audio> _sounds = <Audio>[].obs;

  List<Audio> get sounds => _sounds;

  final RxMap<int, AudioPlayer> _players = <int, AudioPlayer>{}.obs;
  final RxMap<int, RxBool> _isPlaying = <int, RxBool>{}.obs;
  final RxMap<int, double> _volumes = <int, double>{}.obs;
  Map<int, double> get volumes => _volumes.value;

  @override
  void onInit() {
    super.onInit();
    loadSoundsAndInitializePlayers();
  }

  /* init */
  Future<void> loadSoundsAndInitializePlayers() async {
    try {
      final loadedSounds = await _useCase.execute('sound');
      _sounds.assignAll(loadedSounds);

      for (var sound in loadedSounds) {
        final player = await _audioService.createPlayer(sound.audioUrl);
        _players[sound.id] = player;
        _isPlaying[sound.id] = false.obs;
        _volumes[sound.id] = 1.0;

        player.playerStateStream.listen((state) {
          _isPlaying[sound.id]?.value = state.playing;
        });
      }
    } catch (e) {
      print('Error loading sounds and initializing players: $e');
    }
  }

  @override
  void onClose() {
    for (var player in _players.values) {
      _audioService.dispose(player);
    }
    _players.clear();
    super.onClose();
  }

  Future<void> togglePlay(int audioId) async {
    if (_players.containsKey(audioId)) {
      final player = _players[audioId]!;
      if (_isPlaying[audioId]?.value == true) {
        await _audioService.pause(player);
      } else {
        await _audioService.play(player);
      }
      _isPlaying[audioId]?.toggle();
    }
  }

  Future<void> stopAudio(int audioId) async {
    if (_players.containsKey(audioId)) {
      await _audioService.stop(_players[audioId]!);
      _isPlaying[audioId]?.value = false;
    }
  }

  Future<void> setVolume(int audioId, double volume) async {
    if (_players.containsKey(audioId)) {
      await _audioService.setVolume(_players[audioId]!, volume);
      _volumes[audioId] = volume;
    }
  }

  bool isPlaying(int audioId) => _isPlaying[audioId]?.value ?? false;
  double getVolume(int audioId) => _volumes[audioId] ?? 1.0;
}
