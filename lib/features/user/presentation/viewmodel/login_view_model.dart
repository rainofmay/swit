import 'package:get/get.dart';
import 'package:swit/core/utils/user/login_service.dart';
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


  /* ------------------------------------------------------ */
  /* Google Auth ------------------------------------------ */
  /* ------------------------------------------------------ */
  Future<void> signInWithGoogle() async {
    try {
      await _googleLoginUseCase.signInWithGoogle();
      await _loginService.setLoginState(true);
      CustomSnackbar.show(title: '로그인', message: '로그인 되었습니다.');
    } catch (e) {
      CustomSnackbar.showLoginError;
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      await _googleLoginUseCase.signOutWithGoogle();
      await _loginService.setLoginState(false);
      CustomSnackbar.show(title: '로그아웃', message: '로그아웃 되었습니다.');
    } catch (e) {
      CustomSnackbar.showLoginError;
    }
  }


}