import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/usecases/google_login_use_case.dart';


class LoginViewModel extends GetxController {
  final GoogleLoginUseCase _googleLoginUseCase;

  LoginViewModel({
    required GoogleLoginUseCase googleLoginUseCase,
  })  : _googleLoginUseCase = googleLoginUseCase;

  late final Rx<User?> _user = null.obs;
  User? get user => _user.value;


  Future<void> signInWithGoogle() async {
    try {
      final user = await _googleLoginUseCase.signInWithGoogle();
      _user.value = user;
    } catch (e) {
      // 에러 처리
      Get.snackbar('Error', 'Failed to sign in with Google: ${e.toString()}');
    } finally {
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      await _googleLoginUseCase.signOutWithGoogle();
      _user.value = null;
    } catch (e) {
      // 에러 처리
      Get.snackbar('Error', 'Failed to sign out: ${e.toString()}');
    } finally {
    }
  }
}