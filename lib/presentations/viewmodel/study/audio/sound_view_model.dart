import 'package:get/get.dart';
import 'package:swit/domain/repository/study/audio/sound_repository.dart';
import 'package:swit/domain/usecases/study/audio/get_sound_use_case.dart';

class SoundViewModel extends GetxController {
  final GetSoundUseCase _usecase;

  SoundViewModel({required GetSoundUseCase usecase}) : _usecase = usecase;

  @override
  void onInit() async {

    super.onInit();
  }

  @override
  void dispose() {

    super.dispose();
  }

}