import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/constant/color_box.dart';
import 'package:swit/constant/font_box.dart';
import 'package:swit/presentations/viewmodel/study/audio/sound_view_model.dart';
import 'package:swit/presentations/widgets/common/custom_gap.dart';

class SoundVolume extends StatelessWidget {
  final int playerIndex;

  SoundVolume(
      {super.key,
      required this.playerIndex,
      });

  final SoundViewModel viewModel = Get.find<SoundViewModel>();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical : 8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        SizedBox(
          width: 130,
          child: Text(viewModel.soundPlayersList[playerIndex].musicName,
              style: FontBox.MINISTYLE,
              overflow: TextOverflow.ellipsis),
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
                  Obx(
                    () => IconButton(
                        splashColor: ColorBox.transparent,
                        highlightColor: ColorBox.transparent,
                        hoverColor: ColorBox.transparent,
                        icon: Icon(
                          viewModel.soundPlayersList[playerIndex].isPlaying.value
                              ? CupertinoIcons.speaker_2
                              : CupertinoIcons.speaker_slash,
                          color: ColorBox.white,
                        ),
                        iconSize: 16.0,
                        onPressed: () {
                          if (viewModel.soundPlayersList[playerIndex].isPlaying.value == true) {
                            viewModel.musicPause(playerIndex);
                          } else {
                            if (viewModel
                                    .soundPlayersList[playerIndex].audioPlayer.state == PlayerState.paused) {
                              viewModel
                                  .soundPlayersList[playerIndex].audioPlayer.resume();
                            } else {
                              viewModel.musicPlay(playerIndex);
                            }
                          }
                        }),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Slider(
                      value: _volume,
                      onChanged: (volume) {
                        _adjustVolume(volume);
                      },
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

