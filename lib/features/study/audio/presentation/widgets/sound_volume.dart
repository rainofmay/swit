import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/audio/presentation/widgets/circle.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/sound_view_model.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class SoundVolume extends GetView<SoundViewModel> {
  final Audio audio;
  final String imageUrl;

  const SoundVolume({super.key, required this.audio, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), // 어둡게
                  BlendMode.darken,
                )
            )),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Circle(
              backgroundColor: ColorBox.thirdColor,
              child: Obx(() => IconButton(
                  splashColor: ColorBox.transparent,
                  highlightColor: ColorBox.transparent,
                  hoverColor: ColorBox.transparent,
                  icon: Icon(
                    controller.isPlaying(audio.id)
                        ? CupertinoIcons.speaker_2
                        : CupertinoIcons.speaker_slash,
                    color: ColorBox.black,
                  ),
                  iconSize: 16.0,
                  onPressed: () {
                    controller.togglePlay(audio.id);
                  }))),
          const CustomGap(16),
          SizedBox(
            width: 130,
            child: Text(audio.name,
                style: FontBox.MINISTYLE.copyWith(color: ColorBox.white),
                overflow: TextOverflow.ellipsis),
          ),
          const CustomGap(4),
          SliderTheme(
            data: Theme.of(context).sliderTheme,
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() => SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Slider(
                            value: controller.getVolume(audio.id),
                            onChanged: (volume) =>
                                controller.setVolume(audio.id, volume),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
