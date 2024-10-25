import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/di/home_binding.dart';
import 'package:swit/core/di/audio_binding.dart';
import 'package:swit/core/di/login_binding.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/core/di/notification_binding.dart';
import 'package:swit/core/di/record_binding.dart';
import 'package:swit/core/di/schedule_binding.dart';
import 'package:swit/core/di/setting_binding.dart';
import 'package:swit/core/di/swit_binding.dart';
import 'package:swit/core/di/swit_post_it_bindiing.dart';
import 'package:swit/core/di/swit_setting_binding.dart';
import 'package:swit/core/di/user_binding.dart';
import 'package:swit/core/middleware/login_middleware.dart';
import 'package:swit/core/utils/audio/my_audio_handler.dart';
import 'package:swit/features/home/presentations/view/home_screen.dart';
import 'package:swit/features/mate/presentation/view/mate_add_screen.dart';
import 'package:swit/features/mate/presentation/view/mate_screen.dart';
import 'package:swit/features/study/notification/presentation/view/notification_screen.dart';
import 'package:swit/features/study/swit/presentation/view/swit_create_screen.dart';
import 'package:swit/features/study/swit/presentation/view/swit_post_it_create_screen.dart';
import 'package:swit/features/study/swit/presentation/view/swit_post_it_screen.dart';
import 'package:swit/features/user/presentation/view/profile_edit_screen.dart';
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

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),

    /* ------------------------------------------------------ */
    /* Study Fields ----------------------------------------- */
    /* ------------------------------------------------------ */

    GetPage(
      name: Routes.STUDY,
      page: () => const StudyScreen(),
      middlewares: [LoginMiddleware()],
      children: [

        /* -- Notification -- */
        GetPage(
          name: Routes.NOTIFICATION,
          page: () => NotificationScreen(),
          binding: NotificationBinding(),
        ),

        /* -- Audio -- */
        GetPage(
          name: Routes.AUDIO,
          page: () => FutureBuilder<AudioHandler>(
            //future : 어떤 비동기 작업을 기다려야 하는 지 알려주는 것.(initAudioService 는 비동기 작업임)
            future: Get.putAsync<AudioHandler>(() => initAudioService()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AudioScreen();
              } else {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }
            },
          ),
          binding: AudioBinding(),
        ),

       /* -- Swit -- */
        GetPage(
          name: Routes.SWIT,
          page: () => const SwitScreen(),
          binding: SwitBinding(),
          children: [
            GetPage(
              name: Routes.SWITPOST,
              page: () => const SwitPostItScreen(),
              binding: SwitPostItBindiing(),
              children: [
                GetPage(
                  name: Routes.SWITCREATEPOST,
                  page: () => const SwitPostItCreateScreen(),
                  binding: SwitPostItBindiing(),
                )
              ],
            ),
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
            GetPage(
                name: Routes.CREATESWIT,
                page: () => SwitCreateScreen(),
                bindings: [MateBinding(), SwitBinding()])
          ],
        ),

        GetPage(
          name: Routes.SCHEDULE,
          page: () => const ScheduleScreen(),
          binding: ScheduleBinding(),
          children: [
            GetPage(
              name: Routes.CREATESCHEDULE,
              page: () => const CreateScheduleScreen(),
            ),
            GetPage(
              name: Routes.EDITSCHEDULE,
              page: () => const EditScheduleScreen(),
            )
          ],
        ),
      ],
    ),

    /* ------------------------------------------------------ */
    /* Mate Fields ------------------------------------------ */
    /* ------------------------------------------------------ */
    GetPage(
      name: Routes.MATE,
      page: () => MateScreen(),
      binding: MateBinding(),
      children: [
        GetPage(
          name: Routes.ADDMATE,
          page: () => const MateAddScreen(),
          middlewares: [LoginMiddleware()],
        ),
      ],
    ),

    /* ------------------------------------------------------ */
    /* Record Fields ---------------------------------------- */
    /* ------------------------------------------------------ */
    GetPage(
      name: Routes.RECORD,
      page: () => const RecordScreen(),
      binding: RecordBinding(),
      children: [
        GetPage(
          name: Routes.ADDRECORD,
          page: () => const AddRecordScreen(),
          middlewares: [LoginMiddleware()],
          children: [
            GetPage(
              name: Routes.TIMERECORD,
              page: () => const TaskTimerScreen(),
            ),
            GetPage(
              name: Routes.ADDTASK,
              page: () => const AddTaskScreen(),
            ),
            GetPage(
              name: Routes.EDITTASK,
              page: () => const EditTaskScreen(),
            )
          ],
        )
      ],
    ),

    /* ------------------------------------------------------ */
    /* More Fields ------------------------------------------ */
    /* ------------------------------------------------------ */
    GetPage(
      name: Routes.MORE,
      page: () => MoreScreen(),
      binding: LoginBinding(),
      children: [
        GetPage(
          name: Routes.USERINFO,
          page: () => const UserInfoScreen(),
          binding: LoginBinding(),
        ),
      ],
    ),

    /* ------------------------------------------------------ */
    /* User Fields ------------------------------------------ */
    /* ------------------------------------------------------ */
    GetPage(
      name: Routes.EDITPROFILE,
      page: () => ProfileEditScreen(),
      binding: UserBinding(),
      middlewares: [LoginMiddleware()],
    ),

    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
