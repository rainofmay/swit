import 'package:flutter/material.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/music_view_model.dart';
import 'package:swit/features/study/audio/presentation/widgets/music_player.dart';

class MusicSector extends StatelessWidget {
  final MusicViewModel viewModel;
  const MusicSector({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: MusicPlayer(viewModel: viewModel)),
      ],
    );
  }
}
