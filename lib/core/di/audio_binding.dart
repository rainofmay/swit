import 'package:get/get.dart';
import 'package:swit/core/utils/audio_service.dart';
import 'package:swit/features/study/audio/data/datasources/music_remote_data_source.dart';
import 'package:swit/features/study/audio/data/datasources/sound_remote_data_source.dart';
import 'package:swit/features/study/audio/data/repsoitories/music_repository_impl.dart';
import 'package:swit/features/study/audio/data/repsoitories/sound_repository_impl.dart';
import 'package:swit/features/study/audio/domain/repositories/music_repository.dart';
import 'package:swit/features/study/audio/domain/repositories/sound_repository.dart';
import 'package:swit/features/study/audio/domain/usecases/get_music_use_case.dart';
import 'package:swit/features/study/audio/domain/usecases/get_sound_use_case.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/music_view_model.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/sound_view_model.dart';

class AudioBinding extends Bindings {
  @override
  void dependencies() {
    // Data Source
    Get.put<MusicRemoteDataSource>(MusicRemoteDataSource(), permanent: true);
    Get.put<SoundRemoteDataSource>(SoundRemoteDataSource(), permanent: true);

    // Repository
    Get.put<MusicRepository>(
        MusicRepositoryImpl(Get.find<MusicRemoteDataSource>()),
        permanent: true
    );
    Get.put<SoundRepository>(
        SoundRepositoryImpl(Get.find<SoundRemoteDataSource>()),
        permanent: true
    );

    // Use Case
    Get.put(GetMusicUseCase(Get.find<MusicRepository>()), permanent: true);
    Get.put(GetSoundUseCase(Get.find<SoundRepository>()), permanent: true);

    // Service
    Get.put(AudioService(), permanent: true);

    // ViewModel
    Get.put(
        MusicViewModel(
          useCase: Get.find<GetMusicUseCase>(),
          audioService: Get.find<AudioService>(),
        ),
        permanent: true
    );
    Get.put(
        SoundViewModel(
          useCase: Get.find<GetSoundUseCase>(),
          audioService: Get.find<AudioService>(),
        ),
        permanent: true
    );
  }
}