import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/app/config/app_config.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/core/utils/audio/my_audio_handler.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/home/presentations/view/home_screen.dart';
import 'package:swit/features/home/presentations/viewmodel/home_viewmodel.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/study/swit/presentation/viewmodel/bg_setting_view_model.dart';
import 'shared/constant/color_box.dart';
import 'shared/constant/themes.dart' as main_themes;

Future<void> main() async {
  // await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  await dotenv.load();
  await Supabase.initialize(
      url: dotenv.get("PROJECT_URL"),
      anonKey: dotenv.get("PROJECT_API_KEY")
  );

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorBox.white, // 앱 상단 색
      // systemNavigationBarColor: ColorBox.white, // 앱 하단 색
    ));
    return GetMaterialApp(
      title: AppConfig.APP_TITLE,

      // Localization
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ko', 'KR'),

      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() async {
        Get.put(BgSettingViewModel());
        Get.put(HomeViewModel());
        // Get.put(LoginService());
        }),

      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: main_themes.theme,
      home: const HomeScreen(),
    );
  }
}
