import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/audio/sound/presentation/widgets/sound_sector.dart';
import 'package:swit/shared/widgets/custom_alert_dialog.dart';
import 'package:swit/shared/widgets/glassmorphism.dart';
import 'package:swit/shared/widgets/ok_cancel._buttons.dart';

class AudioWindow extends StatelessWidget {
  const AudioWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      blur: 0.3,
      opacity: 0.65,
      child: CustomAlertDialog(
          title: 'Audio',
          width: MediaQuery.of(context).size.width * 0.55,
          height: MediaQuery.of(context).size.height * 0.45,
          contents: SingleChildScrollView(
            child: Column(
              children: [
                const Text('음악'),
                const Text('소리'),
                SoundSector(),
              ],
            ),
          ),
          actionWidget: OkCancelButtons(okText: '확인', onPressed: () => Get.back())),
    );
  }
}
