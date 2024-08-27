import 'package:get/get.dart';
import 'package:swit/core/di/home_binding.dart';
import 'package:swit/core/di/audio_binding.dart';
import 'package:swit/features/home/presentations/view/home_screen.dart';
import 'package:swit/features/study/audio/presentation/view/audio_screen.dart';
import 'package:swit/features/study/setting/presentation/view/background_setting_screen.dart';
import 'package:swit/features/study/setting/presentation/view/setting_screen.dart';
import 'package:swit/features/study/study_screen.dart';
// 다른 필요한 import 추가

part 'app_routes.dart';


class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: Routes.STUDY,
          page: () => const StudyScreen(),
          children: [
            GetPage(
              name: Routes.AUDIO,
              page: () => const AudioScreen(),
              binding: AudioBinding(),
            ),
            GetPage(
              name: Routes.SETTING,
              page: () => const SettingScreen(),
              children: [
                GetPage(name: Routes.BACKGROUNDSETTING, page: () => const BackgroundSettingScreenScreen())
              ]
            ),
          ],
        ),

      ],
    ),
  ];
}