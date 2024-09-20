import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleLoginRemoteDataSource {
  GoogleLoginRemoteDataSource._internal();

  static final GoogleLoginRemoteDataSource _instance = GoogleLoginRemoteDataSource._internal();

  factory GoogleLoginRemoteDataSource () {
    return _instance;
  }

  final supabase = Supabase.instance.client;

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId:
    '167838128706-f9nme0m8pld5iiuokoc6pn5g430gf2k8.apps.googleusercontent.com',
    serverClientId:
    '167838128706-5fq7g0l5cr2qvu0ihig75b8v40l4u0bf.apps.googleusercontent.com',
  );

  /* -- 구글 로그인 -- */
  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if (googleAuth == null || googleAuth.idToken == null || googleAuth.accessToken == null) {
        throw Exception('로그인 실패');
      }

      // 사용자 정보 가져오기
      String? email = googleUser?.email;
      String? name = googleUser?.displayName;
      String? profileUrl = '';

      // String? profileUrl = googleUser?.photoUrl;

      if (email == null) {
        print('오류 : 이메일 정보를 가져올 수 없습니다.');
        return;
      }

      bool userExists = await checkUserExists(email);

      if (userExists) {
        await loginUserWithGoogle(email, googleAuth.idToken!, googleAuth.accessToken!);
      } else {
        await registerUserWithGoogle(email, name, profileUrl, googleAuth.idToken!, googleAuth.accessToken!);
      }

    } catch (error) {
      print(error);
      // CustomSnackbar.show(title: '실패', message: '다시 시도해 주세요.');
    }
  }

  Future<void> loginUserWithGoogle(String email, String idToken, String accessToken) async {
    try {
      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null) {
        throw Exception('로그인 실패');
      }

      // JWT 토큰에 커스텀 클레임 추가
      await supabase.auth.updateUser(
        UserAttributes(
          data: {'is_google_user': true},
        ),
      );

    } catch (error) {
      print('Google 로그인 중 오류 발생: $error');
      rethrow;
    }
  }

  Future<void> registerUserWithGoogle(String email, String? name, String? profileUrl, String idToken, String accessToken) async {
    try {
      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null) {
        throw Exception('회원가입 실패');
      }

      // JWT 토큰에 커스텀 클레임 추가
      await supabase.auth.updateUser(
        UserAttributes(
          data: {'is_google_user': true},
        ),
      );

      // 사용자 정보 저장
      await supabase.from('user').insert({
        // 'id': response.user!.id,
        'email': email,
        'username': name,
        'profile_url':profileUrl,
      });

    } catch (error) {
      print('Google 회원가입 중 오류 발생: $error');
      rethrow;
    }
  }

  Future<bool> checkUserExists(String email) async {
    try {
      final response = await supabase
          .from('user')
          .select()
          .eq('email', email)
          .single();
      // 사용자가 존재하면 response가 null이 아님
      return true;
    } catch (error) {
      // PostgrestException을 확인하여 사용자가 없는 경우를 구분
      if (error is PostgrestException && error.code == 'PGRST116') {
        // 사용자를 찾을 수 없음 (정상적인 상황)
        return false;
      } else {
        // 다른 종류의 오류 발생
        print('사용자 확인 중 오류 발생: $error');
        // 오류 발생 시 false를 반환하거나, 필요에 따라 예외를 다시 throw할 수 있음
        return false;
      }
    }
  }

  /* -- 구글 로그아웃 -- */
  Future<void> signOut() async {
    googleSignIn.signOut(); // supabase 세션은 그대로 살아있는 듯
    await supabase.auth.signOut(); // auth 로그아웃, 로컬에 저장된 토큰 정보 삭, 서버측 세션 정보 갱신
  }
}