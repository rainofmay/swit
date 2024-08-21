import 'package:get/get.dart';
import 'package:swit/core/utils/audio_service.dart';
import 'package:swit/domain/entities/study/audio/audio.dart';
import 'package:swit/domain/entities/study/audio/audio_player_state.dart';
import 'package:swit/domain/usecases/study/audio/get_sound_use_case.dart';

class SoundViewModel extends GetxController {
  final GetSoundUseCase _usecase;
  final AudioService _audioService;

  SoundViewModel(
      {required GetSoundUseCase usecase, required AudioService audioService})
      : _usecase = usecase,
        _audioService = audioService;


  final RxList<Audio> _sounds = <Audio>[].obs;
  List<Audio> get sounds => _sounds;
  final Rx<AudioPlayerState?> _currentAudioState = Rx<AudioPlayerState?>(null);


  bool isPlaying(int audioId) => _audioService.isPlaying(audioId);
  double getVolume(int audioId) => _audioService.getVolume(audioId);

  @override
  void onInit() {
    print('음원 $_sounds');
    loadSounds('sound');
    _audioService.playerStateStream.listen((state) {
      _currentAudioState.value = state;
    });
    super.onInit();
  }

  @override
  void onClose() {
    _audioService.dispose();
    super.onClose();
  }

  /* 음원 Init */
  Future<void> loadSounds(String theme) async {
    try {
      final loadedSounds = await _usecase.execute(theme);
      sounds.assignAll(loadedSounds);
    } catch (e) {
      print('Error loading sounds: $e');
    }
  }

  /* 오디오 제어 메서드 */
  Future<void> togglePlay(Audio audio) async {
    if (isPlaying(audio.id)) {
      await pauseAudio(audio.id);
    } else {
      await playAudio(audio);
    }
  }

  Future<void> playAudio(Audio audio) async {
    await _audioService.play(audio);
  }

  Future<void> pauseAudio(int soundId) async {
    await _audioService.pause(soundId);
  }

  Future<void> stopAudio(int soundId) async {
    await _audioService.stop(soundId);
  }

  Future<void> setVolume(int audioId, double volume) async {
    await _audioService.setVolume(audioId, volume);
  }

}


