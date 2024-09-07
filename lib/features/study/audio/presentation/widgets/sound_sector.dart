import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/audio/presentation/widgets/sound_volume.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/sound_view_model.dart';

class SoundSector extends GetView<SoundViewModel> {
  SoundSector({super.key});
  final imageUrls = ['assets/images/music/fire.jpg', 'assets/images/music/rain.jpg', 'assets/images/music/wave.jpg', 'assets/images/music/bug.jpg'];

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.sounds.length,
        itemBuilder: (BuildContext context, int index) {
          final audio = controller.sounds[index];
          final imageUrl = imageUrls[index];
          return SoundVolume(
            audio: audio,
            imageUrl : imageUrl,
          );
        }));
  }
}
