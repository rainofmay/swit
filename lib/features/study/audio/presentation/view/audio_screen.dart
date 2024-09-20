import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/audio/my_audio_handler.dart';
import 'package:swit/features/study/audio/domain/usecases/get_music_use_case.dart';
import 'package:swit/features/study/audio/domain/usecases/get_sound_use_case.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/music_view_model.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/sound_view_model.dart';
import 'package:swit/features/study/audio/presentation/widgets/music_sector.dart';
import 'package:swit/features/study/audio/presentation/widgets/sound_sector.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

  class AudioScreen extends StatelessWidget {
    AudioScreen({super.key});

    final musicVM = Get.put<MusicViewModel>(
        MusicViewModel(
            useCase: Get.find<GetMusicUseCase>(),
            audioHandler: Get.find<AudioHandler>()),
        permanent: true);
    final soundVM = Get.put<SoundViewModel>(
        SoundViewModel(
            useCase: Get.find<GetSoundUseCase>(),
            audioHandler: Get.find<AudioHandler>()),
        permanent: true);


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorBox.secondColor,
      appBar: CustomBackAppBar(
          appbarTitle: '음 악',
          isLeading: true,
          isCenterTitle: true,
          backgroundColor: ColorBox.secondColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MusicSector(viewModel: musicVM),
            SoundSector(viewModel: soundVM),
          ],
        ),
      ),
    );
  }
}
