import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/constant/color_box.dart';
import 'package:swit/constant/font_box.dart';
import 'package:swit/domain/entities/study/audio/audio.dart';
import 'package:swit/presentations/viewmodel/study/audio/sound_view_model.dart';
import 'package:swit/presentations/widgets/common/custom_gap.dart';

class SoundVolume extends GetView<SoundViewModel> {
  final Audio audio;

  const SoundVolume({
    super.key,
    required this.audio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          width: 130,
          child: Text(audio.name,
              style: FontBox.MINISTYLE, overflow: TextOverflow.ellipsis),
        ),
        const CustomGap(4),
        SliderTheme(
          data: const SliderThemeData(), // themes.dart에 있음.
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                        splashColor: ColorBox.transparent,
                        highlightColor: ColorBox.transparent,
                        hoverColor: ColorBox.transparent,
                        icon: Icon(
                          controller.isPlaying(audio.id) ? CupertinoIcons.speaker_2 : CupertinoIcons.speaker_slash,
                          color: ColorBox.black,
                        ),
                        iconSize: 16.0,
                        onPressed: () {
                          controller.togglePlay(audio);
                        }
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Slider(
                      value: controller.getVolume(audio.id),
                      onChanged: (volume) => controller.setVolume(audio.id, volume),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
