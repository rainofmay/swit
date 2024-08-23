// 예: GetX를 사용한 의존성 주입
import 'package:get/get.dart';
import 'package:swit/core/utils/audio_service.dart';
import 'package:swit/features/study/audio/sound/data/datasources/sound_remote_data_source.dart';
import 'package:swit/features/study/audio/sound/data/repsoitories/sound_repository_impl.dart';
import 'package:swit/features/study/audio/sound/domain/repositories/sound_repository.dart';
import 'package:swit/features/study/audio/sound/domain/usecases/get_sound_use_case.dart';
import 'package:swit/features/study/audio/sound/presentation/viewmodel/sound_view_model.dart';

class SoundBinding extends Bindings {
  @override
  void dependencies() {
    // Data Source
    Get.lazyPut<SoundRemoteDataSource>(() => SoundRemoteDataSource());

    // Repository
    Get.lazyPut<SoundRepository>(() => SoundRepositoryImpl(Get.find<SoundRemoteDataSource>()));

    // Use Case
    Get.lazyPut(() => GetSoundUseCase(Get.find<SoundRepository>()));

    // Service
    Get.lazyPut(() => AudioService(), fenix: true);

    // ViewModel
    Get.lazyPut(() => SoundViewModel(
      useCase: Get.find<GetSoundUseCase>(),
      audioService: Get.find<AudioService>(),
    ));
  }
}