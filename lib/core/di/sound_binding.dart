// 예: GetX를 사용한 의존성 주입
import 'package:get/get.dart';
import 'package:swit/data/data_source/remote/study/audio/sound_remote_data_source.dart';
import 'package:swit/data/repositories/study/audio/sound_repository_impl.dart';
import 'package:swit/domain/repository/study/audio/sound_repository.dart';
import 'package:swit/domain/usecases/study/audio/get_sound_use_case.dart';
import 'package:swit/presentations/viewmodel/study/audio/sound_view_model.dart';

class SoundBinding extends Bindings {
  @override
  void dependencies() {
    // 데이터 계층 생성
    Get.lazyPut(() => SoundRemoteDataSource());
    Get.lazyPut<SoundRepository>(() => SoundRepositoryImpl(Get.find<SoundRemoteDataSource>()));

    // UseCase 생성 (도메인 계층의 Repository 사용)
    Get.lazyPut(() => GetSoundUseCase(Get.find<SoundRepository>()));

    // ViewModel 생성
    Get.lazyPut(() => SoundViewModel(usecase: Get.find<GetSoundUseCase>()));
  }
}