import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/constant/font_box.dart';
import 'package:swit/presentations/view/study/audio/sound/sound_volume.dart';
import 'package:swit/presentations/viewmodel/study/audio/sound_view_model.dart';
import 'package:swit/presentations/widgets/common/custom_gap.dart';

class SoundSector extends GetView<SoundViewModel> {
  const SoundSector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(children: [
         Icon(Icons.headphones_rounded, size: 14),
         CustomGap(8),
         Text('소리', style: FontBox.CONTENTSTYLE),
        ]),
        Obx(() => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.sounds.length,
            itemBuilder: (BuildContext context, int index) {
              final audio = controller.sounds[index];
              return SoundVolume(
                audio: audio,
              );
            })),
      ],
    );
  }
}
