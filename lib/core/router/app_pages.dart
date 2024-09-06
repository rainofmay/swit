import 'package:get/get.dart';
import 'package:swit/core/di/home_binding.dart';
import 'package:swit/core/di/audio_binding.dart';
import 'package:swit/core/di/schedule_binding.dart';
import 'package:swit/core/di/setting_binding.dart';
import 'package:swit/features/home/presentations/view/home_screen.dart';
import 'package:swit/features/study/audio/presentation/view/audio_screen.dart';
import 'package:swit/features/study/schedule/presentation/view/create_schedule_screen.dart';
import 'package:swit/features/study/schedule/presentation/view/edit_schedule_screen.dart';
import 'package:swit/features/study/schedule/presentation/view/schedule_screen.dart';
import 'package:swit/features/study/setting/presentation/view/bg_setting_screen.dart';
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
          page: () => StudyScreen(),
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
                  GetPage(
                    name: Routes.BACKGROUNDSETTING,
                    page: () => const BgSettingScreen(),
                    binding: SettingBinding(),
                  ),
                ]),
            GetPage(
                name: Routes.SCHEDULE,
                page: () => const ScheduleScreen(),
                binding: ScheduleBinding(),
                children: [
                  GetPage(
                      name: Routes.CREATESCHEDULE,
                      page: () => const CreateScheduleScreen()),
                  GetPage(
                      name: Routes.EDITSCHEDULE,
                      page: () => const EditScheduleScreen())
                ]),
          ],
        ),
      ],
    ),
  ];
}
