import 'package:get/get.dart';
import 'package:swit/core/di/home_binding.dart';
import 'package:swit/core/di/audio_binding.dart';
import 'package:swit/core/di/login_binding.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/core/di/record_binding.dart';
import 'package:swit/core/di/schedule_binding.dart';
import 'package:swit/core/di/setting_binding.dart';
import 'package:swit/core/di/swit_setting_binding.dart';
import 'package:swit/core/middleware/login_middleware.dart';
import 'package:swit/features/home/presentations/view/home_screen.dart';
import 'package:swit/features/mate/presentation/view/create_post_it_screen.dart';
import 'package:swit/features/mate/presentation/view/mate_add_screen.dart';
import 'package:swit/features/mate/presentation/view/mate_screen.dart';
import 'package:swit/features/more/presentation/view/more.screen.dart';
import 'package:swit/features/more/presentation/view/user_info_screen.dart';
import 'package:swit/features/record/presentation/view/add_record_screen.dart';
import 'package:swit/features/record/presentation/view/add_task_screen.dart';
import 'package:swit/features/record/presentation/view/edit_task_screen.dart';
import 'package:swit/features/record/presentation/view/record_screen.dart';
import 'package:swit/features/record/presentation/view/task_timer_screen.dart';
import 'package:swit/features/study/audio/presentation/view/audio_screen.dart';
import 'package:swit/features/study/schedule/presentation/view/create_schedule_screen.dart';
import 'package:swit/features/study/schedule/presentation/view/edit_schedule_screen.dart';
import 'package:swit/features/study/schedule/presentation/view/schedule_screen.dart';
import 'package:swit/features/study/study_screen.dart';
import 'package:swit/features/study/swit/presentation/view/bg_setting_screen.dart';
import 'package:swit/features/study/swit/presentation/view/swit_screen.dart';
import 'package:swit/features/study/swit/presentation/view/swit_setting_screen.dart';
import 'package:swit/features/user/presentation/view/login_screen.dart';

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
          middlewares: [LoginMiddleware()], // 미들웨어 테스트
          children: [
            GetPage(
              name: Routes.AUDIO,
              page: () => AudioScreen(),
              binding: AudioBinding(),
            ),
            GetPage(
                name: Routes.SWIT,
                page: () => const SwitScreen(),
                children: [
                  GetPage(
                    name: Routes.SWITSETTING,
                    page: () => const SwitSettingScreen(),
                    binding: SwitSettingBinding(),
                    children: [
                      GetPage(
                        name: Routes.BACKGROUNDSETTING,
                        page: () => const BgSettingScreen(),
                        binding: SettingBinding(),
                      )
                    ],
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
    GetPage(
        name: Routes.MATE,
        page: () => MateScreen(),
        binding: MateBinding(),
        children: [
          GetPage(
            name: Routes.CREATEPOSTIT,
            page: () => const CreatePostItScreen(),
            middlewares: [LoginMiddleware()],
          ),
          GetPage(
              name: Routes.MATEADD,
              page: () => const MateAddScreen(),
              middlewares: [LoginMiddleware()],
          )
        ]),
    GetPage(
        name: Routes.RECORD,
        page: () => const RecordScreen(),
        binding: RecordBinding(),
        children: [
          GetPage(
            name: Routes.RECORDADD,
            page: () => const AddRecordScreen(),
            middlewares: [LoginMiddleware()],
            binding: RecordBinding(),
            children: [
              GetPage(
                name: Routes.TIMERECORD,
                page: () => const TaskTimerScreen(),
                middlewares: [LoginMiddleware()],
                binding: RecordBinding(),
              ),
              GetPage(
                name: Routes.ADDTASK,
                page: () => const AddTaskScreen(),
                middlewares: [LoginMiddleware()],
                binding: RecordBinding(),
              ),
              GetPage(
                name: Routes.EDITTASK,
                page: () => const EditTaskScreen(),
                middlewares: [LoginMiddleware()],
                binding: RecordBinding(),
              )
            ]
          )
        ]),
    GetPage(
        name: Routes.MORE,
        page: () => MoreScreen(),
        binding: LoginBinding(),
        children: [
          GetPage(
            name: Routes.USERINFO,
            page: () => const UserInfoScreen(),
            binding: LoginBinding(),
          )
        ]),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
