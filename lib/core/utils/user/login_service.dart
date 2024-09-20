import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/features/user/presentation/view/login_screen.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';
import 'package:swit/shared/widgets/ok_cancel._buttons.dart';

class LoginService {
  static final _supabase = Supabase.instance.client;

   User? getCurrentSessionUser() {
    final session = _supabase.auth.currentSession;
    // print('sesstion $session');
    return session?.user; // 세션이 있으면 user 반환, 없으면 null 반환
  }

   String? getCurrentUserId() {
    final user = getCurrentSessionUser();
    print("getCurrentUserId : ${user?.id}");
    return user?.id; // user가 있으면 id 반환, 없으면 null 반환
  }

   bool isLoggedIn() {
    return getCurrentSessionUser() != null;
  }

  //토큰이 있으면 그걸로 식별을 하고, 그게 아니면 로그인 창으로 내보낸다.
   Future<String?> getMyId() async {
    if (!isLoggedIn()) {
      print("로그인이 안 되어있습니다.");
      return null;
    }
    final userEmail = getCurrentUserEmail();
    if (userEmail != null) {
      final response = await _supabase
          .from('user')
          .select('uid')
          .eq('email', userEmail)
          .single();
      return response['uid']; // 문자열 형태로 반환
    } else {
      print("Loginservice getCurrentUserId: error");
      return null;
    }
  }

  // 새로운 함수: senderId로 username 조회
  Future<String> getUsernameById(String userId) async {
    try {
      final response = await _supabase
          .from('user')
          .select('username')
          .eq('uid', userId)
          .single();
      return response['username'] as String;
    } catch (e) {
      print('Error Loginservice getUsernameById: $e');
      return 'Unknown User';
    }
  }


  Future<Map<String, dynamic>> getUserById(String userId) async {
    try {
        final userData = await _supabase
            .from('user')
            .select()
            .eq('uid', userId)
            .single();
      return userData;
    } catch (e) {
      print('Error Loginservice getUserById: $e');
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getUsersByIds(List<String> mateIds) async {
     try {
       final List<Map<String, dynamic>> userResponse = [];
       for (var mateId in mateIds) {
         final userData = await _supabase
             .from('user')
             .select()
             .eq('uid', mateId)
             .single();
         userResponse.add(userData);
       }
       return userResponse;

     } catch (e) {
       print('Error Loginservice getUsersByIds: $e');
       return [];
     }
  }


  Future<String?> getUserIdByEmail(String email) async {
     try {
       final response = await _supabase
           .from('user')
           .select('uid')
           .eq('email', email)
           .single(); // 단일 결과 반환
       return response['id'];
     }
     catch (e) {
       print('Error Loginservice getUserIdByEmail: $e');
     }
     return null;
  }

   String? getCurrentUserEmail() {
    final user = getCurrentSessionUser();
    return user?.email; // user가 있으면 email 반환, 없으면 null 반환
  }

  //  Future<void> navigateToLoginScreen(BuildContext context, void Function() navigate) async {
  //   String? userEmail = await getCurrentUserEmail();
  //   if (userEmail == null) {
  //     if (!context.mounted) return;
  //     return customDialog(context, 40, '로그인', Text('로그인이 필요합니다. 하시겠습니까?', style: FontBox.DIALOGSTYLE),
  //         OkCancelButtons(okText: '확인', okTextColor: ColorBox.primaryColor, onPressed: () {
  //           Get.back();
  //           Get.to(() => LoginScreen(), preventDuplicates: true);
  //         }, cancelText: '취소', onCancelPressed: () {
  //           Get.back();
  //         }));
  //   } else {
  //     navigate();
  //     print("로그인 된 사용자 Email: $userEmail");
  //   }
  // }
}
