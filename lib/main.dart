import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/presentations/view/home/home_screen.dart';
import 'package:swit/presentations/viewmodel/bottombar_viewmodel.dart';
import 'constant/themes.dart' as main_themes;
import 'package:firebase_core/firebase_core.dart';
import 'core/di/sound_binding.dart';
import 'firebase_options.dart';

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
  final BottomBarViewModel vm = Get.put(BottomBarViewModel());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // supportedLocales: const [
      //   Locale('ko', 'KR'),
      // ],
      theme: main_themes.theme,
      // initialRoute: initialRoute,  initialRoute를 쓰거나 home을 쓰거나
      home: HomeScreen(),
    );
  }
}
