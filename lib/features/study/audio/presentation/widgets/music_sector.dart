import 'package:flutter/material.dart';
import 'package:swit/features/study/audio/presentation/widgets/circled_music_player.dart';

class MusicSector extends StatelessWidget {
  const MusicSector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: CircledMusicPlayer()),
      ],
    );
  }
}