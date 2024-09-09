import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/audio/presentation/widgets/circle.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/features/study/audio/domain/entities/audio.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/sound_view_model.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class SoundPlayer extends StatelessWidget {
  final Audio audio;
  final String imageUrl;
  final SoundViewModel viewModel;

  const SoundPlayer({
    super.key,
    required this.audio,
    required this.imageUrl,
    required this.viewModel,
  });

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
                  ColorBox.black.withOpacity(0.2), // 어둡게
                  BlendMode.darken,
                ))),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const CustomGap(16),
          Circle(
              backgroundColor: ColorBox.thirdColor,
              child: Obx(() => IconButton(
                  icon: Icon(
                    viewModel.isPlaying(audio.id)
                        ? CupertinoIcons.speaker_2
                        : CupertinoIcons.speaker_slash,
                    color: ColorBox.black,
                  ),
                  iconSize: 16.0,
                  onPressed: () {
                    viewModel.togglePlay(audio.id);
                  }))),
          const CustomGap(16),
          SizedBox(
              width: 140,
              child: Text(audio.name,
                  style: FontBox.WHITEMINI.copyWith(fontWeight: FontWeight.bold))),
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
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Slider(
                            value: viewModel.getVolume(audio.id),
                            onChanged: (volume) =>
                                viewModel.setVolume(audio.id, volume),
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
