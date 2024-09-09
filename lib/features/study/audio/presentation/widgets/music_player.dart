import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/music_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_circular_indicator.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class MusicPlayer extends StatelessWidget {
  final MusicViewModel viewModel;
  const MusicPlayer({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Obx(() {
      if (viewModel.isLoading) {
        return const Center(child: CustomCircularIndicator(size: 30.0));
      }
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const CustomGap(16),
        Text(viewModel.currentMusic.name,
            style: FontBox.MIDDLETITLE),
        const CustomGap(8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: AssetImage('assets/images/music/music_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const CustomGap(24),
        Container(
          width: 240,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: viewModel.toggleShuffle,
                  icon: Icon(
                    CupertinoIcons.shuffle,
                    color: viewModel.isShuffled.value
                        ? ColorBox.primaryColor
                        : ColorBox.black,
                    size: IconSize.md,
                  )),
              IconButton(
                  onPressed: viewModel.previousTrack,
                  icon: Icon(Icons.skip_previous,
                      color: ColorBox.black, size: IconSize.md)),
              IconButton(
                  onPressed: () async {
                    await viewModel.musicPlayPause();
                  },
                  icon: Icon(
                      viewModel.isMusicPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: ColorBox.black,
                      size: IconSize.md)),
              IconButton(
                  onPressed: viewModel.nextTrack,
                  icon: Icon(Icons.skip_next_rounded,
                      color: ColorBox.black, size: IconSize.md)),
              IconButton(
                  onPressed: viewModel.toggleRepeat,
                  icon: Icon(
                      viewModel.isRepeated
                          ? CupertinoIcons.repeat_1
                          : CupertinoIcons.repeat,
                      color: viewModel.isRepeated
                          ? ColorBox.primaryColor
                          : ColorBox.black,
                      size: IconSize.md)),
            ],
          ),
        ),
      ]);
    });
  }
}
