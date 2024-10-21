import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/audio/my_audio_handler.dart';
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
  void dependencies() async {
    /* -- DataSource -- */
    Get.put<MusicRemoteDataSource>(MusicRemoteDataSource());
    Get.put<SoundRemoteDataSource>(SoundRemoteDataSource());

    /* -- Repository -- */
    Get.put<MusicRepository>(
        MusicRepositoryImpl(Get.find<MusicRemoteDataSource>()),
        permanent: true
    );
    Get.put<SoundRepository>(
        SoundRepositoryImpl(Get.find<SoundRemoteDataSource>()),
        permanent: true
    );

    /* -- Use case -- */
    Get.put<GetMusicUseCase>(GetMusicUseCase(Get.find<MusicRepository>()));
    Get.put<GetSoundUseCase>(GetSoundUseCase(Get.find<SoundRepository>()));

    /* -- AudioHandler -- */
    Get.putAsync<AudioHandler>(() async {
      final audioHandler = await initAudioService();
      return audioHandler;
    }, permanent: true);

    /* -- View Model -- */
    // Get.put(MusicViewModel(useCase: Get.find<GetMusicUseCase>(), audioHandler: Get.find<AudioHandler>()), permanent: true);
    // Get.put(SoundViewModel(useCase: Get.find<GetSoundUseCase>(), audioHandler: Get.find<AudioHandler>()), permanent: true);
  }
}

