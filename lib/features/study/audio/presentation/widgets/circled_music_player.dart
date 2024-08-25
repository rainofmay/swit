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

class CircledMusicPlayer extends StatefulWidget {
  const CircledMusicPlayer({super.key});

  @override
  State<CircledMusicPlayer> createState() => _CircledMusicPlayerState();
}

class _CircledMusicPlayerState extends State<CircledMusicPlayer> with SingleTickerProviderStateMixin {
  final vm = Get.find<MusicViewModel>();
  late double progress;
  final ValueNotifier<double> progressNotifier = ValueNotifier(0.0);
  Timer? _timer;

  void updateProgress() {
    // Handle cases where duration is zero or not available
    final currentDuration = vm.currentMusicDuration;
    final currentPosition = vm.currentMusicPosition;

    double progress = (currentDuration.inMilliseconds == 0 ||
        currentPosition.inMilliseconds == 0)
        ? 0.0
        : currentPosition.inMilliseconds.toDouble() /
        currentDuration.inMilliseconds.toDouble();

    progressNotifier.value = progress * 100;
  }

  subscribeDuration() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (mounted) {
        updateProgress();
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    subscribeDuration();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mediaSize = MediaQuery.of(context).size.width;
    return Obx(() {
      if (vm.isLoading) {
        return const Center(child: CustomCircularIndicator(size: 30.0));
      }
      return Column(children: [
        Stack(alignment: Alignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(mediaSize * 0.4),
            child: Image.asset(
              'assets/images/music_background.jpg',
              width: 220,
              height: 220,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: 230,
            height: 230,
            child: AbsorbPointer(
              absorbing: true,
              child: ValueListenableBuilder<double>(
                  valueListenable: progressNotifier,
                  builder: (context, value, child) {
                    return SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                            trackWidth: 2,
                            progressBarWidth: 4,
                            shadowWidth: 16,
                            handlerSize: 4
                        ),
                        customColors: CustomSliderColors(
                            dotColor: ColorBox.primaryColor,
                            trackColor: const Color(0xffFAEE9E).withOpacity(0.3),
                            progressBarColors: [
                              const Color(0xffFAEE9E),
                              const Color(0xffE5A663)
                            ],
                            shadowColor: const Color(0xffFAEE9E),
                            shadowMaxOpacity: 0.05
                        ),
                        infoProperties: InfoProperties(
                          topLabelStyle: const TextStyle(color: Colors.transparent),
                          bottomLabelStyle: const TextStyle(color: Colors.transparent),
                          mainLabelStyle: const TextStyle(color: Colors.transparent),
                        ),
                        animationEnabled: true,
                        animDurationMultiplier: 1,
                        angleRange: 360,
                        startAngle: 270,
                      ),
                      min: 0,
                      max: 100,
                      initialValue: value,
                      onChange: (double value) {},
                    );
                  }
              ),
            ),
          ),
        ]),
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
                  subscribeDuration();
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
