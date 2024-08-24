import 'package:flutter/material.dart';
import 'package:swit/features/study/audio/sound/presentation/widgets/sound_sector.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBar: CustomBackAppBar(appbarTitle: '공부 배경음악', isLeading: true, isCenterTitle: true,),
      body: Column(
        children: [
          Text('음악'),
          Text('소리'),
          SoundSector(),
        ],
      ),
    );
  }
}
