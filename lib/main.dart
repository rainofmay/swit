import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/presentations/view/home/home_screen.dart';
import 'package:swit/presentations/viewmodel/bottombar_viewmodel.dart';
import 'package:swit/test_screen.dart';
import 'constant/themes.dart' as main_themes;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
