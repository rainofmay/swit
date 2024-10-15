import 'package:get/get.dart';
import 'package:swit/app/enums/online_status.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/usecases/update_my_profile_use_case.dart';

class UserViewModel extends GetxController {
  final UpdateMyProfileUseCase _updateMyProfileUseCase;

  UserViewModel({required UpdateMyProfileUseCase updateMyProfileUseCase}) : _updateMyProfileUseCase = updateMyProfileUseCase;

  late final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  // 파생된 옵저버블 속성들
  String get email => _user.value?.email ?? '';
  String get uid => _user.value?.uid ?? '';
  String get username => _user.value?.username ?? '';
  String get profileUrl => _user.value?.profileUrl ?? '';
  String get introduction => _user.value?.introduction ?? '';
  OnlineStatus get onlineStatus =>
      _user.value?.onlineStatus ?? OnlineStatus.offline;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void setUser(User user) {
    _user.value = user;
  }

  Future<void> updateMyProfile({String? username, String? introduction, String? profileUrl}) async {
    if (_user.value == null) return;
    _isLoading.value = true;
    try {
      await _updateMyProfileUseCase.execute(
        userId: _user.value!.uid,
        username: username,
        introduction: introduction,
        profileUrl: profileUrl,
      );

      // Update local user object
      _user.value = User(
        uid: _user.value!.uid,
        email: _user.value!.email,
        username: username ?? _user.value!.username,
        profileUrl: profileUrl ?? _user.value!.profileUrl,
        introduction: introduction ?? _user.value!.introduction,
        onlineStatus: _user.value!.onlineStatus,
      );

      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      print('Error, Failed to update profile: $e');
    } finally {
      _isLoading.value = false;
    }
  }
}