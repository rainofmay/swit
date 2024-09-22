import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:swit/app/enums/social_login_provider.dart';
import 'package:swit/features/user/data/datasources/google_login_remote_data_source.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final GoogleLoginRemoteDataSource _googleDataSource;

  LoginRepositoryImpl(this._googleDataSource);

  @override
  Future signInWithSocial(SocialLoginProvider provider) async {
   switch (provider) {
     case SocialLoginProvider.google :
       await _googleDataSource.signInWithGoogle();
     case SocialLoginProvider.apple :
       await _googleDataSource.signInWithGoogle();
     case SocialLoginProvider.kakao :
       await _googleDataSource.signInWithGoogle();
   }
  }

  @override
  Future<void> signOut(SocialLoginProvider provider) async {
    switch (provider) {
      case SocialLoginProvider.google :
        await _googleDataSource.signOut();
      case SocialLoginProvider.apple :
        await _googleDataSource.signOut();
      case SocialLoginProvider.kakao :
        await _googleDataSource.signOut();
    }
  }
}