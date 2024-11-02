import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/music_view_model.dart';
import 'package:swit/features/study/audio/presentation/widgets/circle.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/action_icon_button.dart';
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: mediaWidth * 0.7,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/music/study3.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorBox.white,
                    blurRadius: 6,
                    spreadRadius: 3,
                    offset: Offset(-2, -2),
                  ),
                  // 오른쪽 하단의 어두운 그림자
                  BoxShadow(
                    color: ColorBox.grey.withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 3,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            const CustomGap(8),
            Positioned(
              bottom: 18,
              child: Row(
                children: [
                  Icon(CupertinoIcons.music_note_2,
                      size: IconSize.sm, color: ColorBox.white),
                  const CustomGap(8),
                  Text(viewModel.currentMusic.name,
                      style: FontBox.B1.copyWith(color: ColorBox.white)),
                ],
              ),
            ),
          ]),
        ),
        const CustomGap(16),
        Obx(() => Container(
              width: mediaWidth * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Circle(
                      backgroundColor: ColorBox.white,
                      child: ActionIconButton(
                        width: 14,
                        height: 14,
                        onTap: viewModel.toggleShuffle,
                        svgAsset: 'assets/icons/music/shuffle.svg',
                        colorFilter: ColorFilter.mode(
                            viewModel.isShuffled ? ColorBox.primaryColor : ColorBox.black,
                            BlendMode.srcIn
                        ),
                      )),
                  Circle(
                      backgroundColor: ColorBox.white,
                      child: ActionIconButton(
                        width: 14,
                        height: 14,
                        onTap: viewModel.previousTrack,
                        svgAsset: 'assets/icons/music/reverse.svg',
                      )),
                  Circle(
                      backgroundColor: ColorBox.white,
                      child: ActionIconButton(
                          width: 14,
                          height: 14,
                          onTap: viewModel.musicPlayPause,
                          svgAsset: viewModel.isMusicPlaying
                              ? 'assets/icons/music/pause.svg'
                              : 'assets/icons/music/play.svg')),
                  Circle(
                      backgroundColor: ColorBox.white,
                      child: ActionIconButton(
                        width: 14,
                        height: 14,
                        onTap: viewModel.nextTrack,
                        svgAsset: 'assets/icons/music/forward.svg',
                      )),
                  Circle(
                      backgroundColor: ColorBox.white,
                      child: ActionIconButton(
                          width: 14,
                          height: 14,
                          onTap: viewModel.toggleRepeat,
                          svgAsset: viewModel.isRepeated
                              ? 'assets/icons/music/repeat_one.svg'
                              : 'assets/icons/music/repeat.svg')),
                ],
              ),
            )),
      ]);
    });
  }
}
