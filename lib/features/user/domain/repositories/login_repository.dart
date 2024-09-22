import 'package:swit/app/enums/social_login_provider.dart';
import 'package:swit/features/user/domain/entities/user.dart';

abstract class LoginRepository {
  Future signInWithSocial(SocialLoginProvider provider);
  Future<void> signOut(SocialLoginProvider provider);
}