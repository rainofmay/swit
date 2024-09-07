  import 'package:flutter/material.dart';
  import 'package:swit/features/study/audio/presentation/widgets/music_sector.dart';
  import 'package:swit/features/study/audio/presentation/widgets/sound_sector.dart';
import 'package:swit/shared/constant/color_box.dart';
  import 'package:swit/shared/widgets/custom_back_appbar.dart';
  import 'package:swit/shared/widgets/custom_scaffold.dart';

  class AudioScreen extends StatelessWidget {
    const AudioScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return CustomScaffold(
        backgroundColor: ColorBox.thirdColor,
        appBar: CustomBackAppBar(appbarTitle: '음 악', isLeading: true, isCenterTitle: true, backgroundColor: ColorBox.thirdColor),
        body: Column(
          children: [
            MusicSector(),
            SoundSector(),
          ],
        ),
      );
    }
  }
