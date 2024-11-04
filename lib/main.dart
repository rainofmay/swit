import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/app/config/app_config.dart';
import 'package:swit/core/data/supabase_service.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/core/di/user_binding.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/home/presentations/view/home_screen.dart';
import 'package:swit/features/home/presentations/viewmodel/home_view_model.dart';
import 'package:swit/features/user/domain/usecases/get_my_profile_use_case.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:swit/shared/widgets/custom_snackbar.dart';
import 'core/utils/user/profile_cache_manager.dart';
import 'shared/constant/color_box.dart';
import 'shared/constant/themes.dart' as main_themes;
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  await Supabase.initialize(
      url: dotenv.get("PROJECT_URL"),
      anonKey: dotenv.get("PROJECT_API_KEY")
  );

  await Get.putAsync(() => SupabaseService().init());


  final supabase = Supabase.instance.client;

  // UserViewModel 초기 프로필 로드

  Future<void> setFcmToken(String fcmToken) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        await supabase
            .from('user_fcm')
            .upsert({'uid': userId, 'fcm_token': fcmToken});
      }
    } catch (e) {
      print('FCM 토큰 저장 실패: $e');
    }
  }

  supabase.auth.onAuthStateChange.listen((event) async {
    if (event.event == AuthChangeEvent.signedIn) {
      await FirebaseMessaging.instance.requestPermission(
        badge: true,
        alert: true,
        sound: true,
      );

      await FirebaseMessaging.instance.getAPNSToken();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        setFcmToken(fcmToken);
      }
    }
  });
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    await setFcmToken(fcmToken);
  });

  //Foreground
  FirebaseMessaging.onMessage.listen((payload) {
    final notification = payload.notification;

    if (notification != null) {
      CustomSnackbar.show(title: '${notification.title}', message: '${notification.body}');
    }
  });
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorBox.black,
        statusBarIconBrightness: Brightness.light, // 앱 상단 색
      // systemNavigationBarColor: ColorBox.white, // 앱 하단 색
    ));
    return GetMaterialApp(
      title: AppConfig.APP_TITLE,

      // Localization
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ko', 'KR'),

      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() async {
        Get.put(HomeViewModel());
        Get.put(MateBinding().dependencies());
        }),

      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: main_themes.theme,
      home: const HomeScreen(),
    );
  }
}
