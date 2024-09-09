import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/audio/presentation/widgets/sound_player.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/sound_view_model.dart';

class SoundSector extends StatelessWidget {
  final SoundViewModel viewModel;
  final imageUrls = ['assets/images/music/fire.jpg', 'assets/images/music/rain.jpg', 'assets/images/music/wave.jpg', 'assets/images/music/bug.jpg'];

  SoundSector({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.sounds.length,
        itemBuilder: (BuildContext context, int index) {
          final audio = viewModel.sounds[index];
          final imageUrl = imageUrls[index];
          return SoundPlayer(
            audio: audio,
            imageUrl : imageUrl,
            viewModel: viewModel,
          );
        }));
  }
}
