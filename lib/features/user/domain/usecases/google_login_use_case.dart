import 'package:swit/core/enums/social_login_provider.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/repositories/login_repository.dart';

class GoogleLoginUseCase {
  final LoginRepository repository;

  GoogleLoginUseCase(this.repository);

  Future signInWithGoogle() async {
    await repository.signInWithSocial(SocialLoginProvider.google);
  }

  Future signOutWithGoogle() async {
    await repository.signOut(SocialLoginProvider.google);
  }
}


