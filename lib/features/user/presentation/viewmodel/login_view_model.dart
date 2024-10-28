import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/usecases/google_login_use_case.dart';
import 'package:swit/shared/widgets/custom_snackbar.dart';


class LoginViewModel extends GetxController {
  final GoogleLoginUseCase _googleLoginUseCase;
  final LoginService _loginService;

  LoginViewModel({
    required GoogleLoginUseCase googleLoginUseCase,
    required LoginService loginService,
  })  : _googleLoginUseCase = googleLoginUseCase,
        _loginService = loginService;

  late final Rx<User?> _user = null.obs;
  User? get user => _user.value;

  bool get isLoggedIn => _loginService.isLoggedIn;

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
      CustomSnackbar.show(title: '로그아웃', message: '로그아웃 되었습니다.');
    } catch (e) {
      // 에러 처리
      Get.snackbar('Error', 'Failed to sign out: ${e.toString()}');
    } finally {
    }
  }
}