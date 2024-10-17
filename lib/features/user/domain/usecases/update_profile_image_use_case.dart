import 'dart:io';

import 'package:swit/features/user/domain/repositories/user_repository.dart';

class UpdateProfileImageUseCase {
  final UserRepository _userRepository;

  UpdateProfileImageUseCase(this._userRepository);

  Future<String> execute(String imagePath) async {
    final imageFile = File(imagePath);
    return await _userRepository.uploadProfileImage(imageFile);
  }

}