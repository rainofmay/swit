import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/domain/usecases/get_sound_use_case.dart';

class SoundViewModel extends GetxController {
  final GetSoundUseCase _useCase;
  final AudioHandler _audioHandler;

  SoundViewModel({
    required GetSoundUseCase useCase,
    required AudioHandler audioHandler,
  })  : _useCase = useCase,
        _audioHandler = audioHandler;

  final RxList<Audio> _sounds = <Audio>[].obs;
  List<Audio> get sounds => _sounds;

  final RxMap<int, RxBool> _isPlaying = <int, RxBool>{}.obs;
  final RxMap<int, RxDouble> _volumes = <int, RxDouble>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadSoundsAndInitializePlayers();
  }

  Future<void> loadSoundsAndInitializePlayers() async {
    try {
      final loadedSounds = await _useCase.execute('sound');
      _sounds.assignAll(loadedSounds);

      for (var sound in loadedSounds) {
        await _audioHandler.customAction('initializeSoundPlayer', {
          'soundId': sound.id,
          'url': sound.audioUrl,
        });
        _isPlaying[sound.id] = false.obs;
        _volumes[sound.id] = 1.0.obs;
      }
    } catch (e) {
      print('Error loading sounds and initializing players: $e');
    }
  }

  @override
  void onClose() {
    _audioHandler.customAction('dispose');
    super.onClose();
  }

  Future<void> togglePlay(int audioId) async {
    if (_isPlaying[audioId] == null) {
      _isPlaying[audioId] = false.obs;
    }

    _isPlaying[audioId]!.toggle();  // 즉시 UI 상태 업데이트

    if (_isPlaying[audioId]!.value) {
      await _audioHandler.customAction('playSoundTrack', {'soundId': audioId});
    } else {
      await _audioHandler.customAction('pauseSoundTrack', {'soundId': audioId});
    }
  }

  Future<void> setVolume(int audioId, double volume) async {
    await _audioHandler.customAction('setSoundVolume', {
      'soundId': audioId,
      'volume': volume,
    });
    _volumes[audioId]?.value = volume;
  }

  bool isPlaying(int audioId) => _isPlaying[audioId]?.value ?? false;
  double getVolume(int audioId) => _volumes[audioId]?.value ?? 1.0;
}