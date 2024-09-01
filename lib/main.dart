import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/home/presentations/view/home_screen.dart';
import 'package:swit/features/home/presentations/viewmodel/home_viewmodel.dart';
import 'package:swit/features/study/setting/presentation/viewmodel/bg_setting_view_model.dart';
import 'shared/constant/themes.dart' as main_themes;

void main() async {
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final HomeViewModel vm = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // supportedLocales: const [
      //   Locale('ko', 'KR'),
      // ],
      initialBinding: BindingsBuilder(() {
        Get.put(BgSettingViewModel());
        // Get.put(MainController());
      }),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: main_themes.theme,
      home: const HomeScreen(),
    );
  }
}
