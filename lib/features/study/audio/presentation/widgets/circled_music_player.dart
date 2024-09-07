import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/music_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_circular_indicator.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class CircledMusicPlayer extends StatelessWidget {
   CircledMusicPlayer({super.key});

  final vm = Get.find<MusicViewModel>();

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Obx(() {
      if (vm.isLoading) {
        return const Center(child: CustomCircularIndicator(size: 30.0));
      }
      return Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/music/music_background.png',
            width: mediaWidth * 0.7,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const CustomGap(24),
        Text(
            vm.currentMusic.name,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                overflow: TextOverflow.ellipsis
            )
        ),
        const CustomGap(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: vm.toggleShuffle,
                icon: Icon(
                    CupertinoIcons.shuffle,
                    color: vm.isShuffled.value ? ColorBox.primaryColor : ColorBox.black,
                    size: IconSize.md,
                )
            ),
            IconButton(
                onPressed: vm.previousTrack,
                icon: Icon(Icons.skip_previous, color: ColorBox.black, size: IconSize.md)
            ),
            IconButton(
                onPressed: () async {
                  await vm.musicPlayPause();
                },
                icon: Icon(
                    vm.isMusicPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: ColorBox.black,
                    size: IconSize.md
                )
            ),
            IconButton(
                onPressed: vm.nextTrack,
                icon: Icon(Icons.skip_next_rounded, color: ColorBox.black, size: IconSize.md)
            ),
            IconButton(
                onPressed: vm.toggleRepeat,
                icon: Icon(
                    vm.isRepeated ? CupertinoIcons.repeat_1 : CupertinoIcons.repeat,
                    color: vm.isRepeated? ColorBox.primaryColor : ColorBox.black,
                    size: IconSize.md
                )
            ),
          ],
        ),
      ]);
    });
  }
}
