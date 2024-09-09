import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/di/audio_binding.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/core/utils/my_audio_handler.dart';
import 'package:swit/features/home/presentations/view/home_screen.dart';
import 'package:swit/features/home/presentations/viewmodel/home_viewmodel.dart';
import 'package:swit/features/study/audio/domain/usecases/get_music_use_case.dart';
import 'package:swit/features/study/audio/presentation/viewmodel/music_view_model.dart';
import 'package:swit/features/study/setting/presentation/viewmodel/bg_setting_view_model.dart';
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

  final audioHandler = await initAudioService();
  Get.put<AudioHandler>(audioHandler, permanent: true);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorBox.white, // 앱 상단 색
      // systemNavigationBarColor: ColorBox.white, // 앱 하단 색
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // supportedLocales: const [
      //   Locale('ko', 'KR'),
      // ],
      initialBinding: BindingsBuilder(() {
        Get.put(BgSettingViewModel());
        Get.put(HomeViewModel());
        }),

      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: main_themes.theme,
      home: const HomeScreen(),
    );
  }
}
