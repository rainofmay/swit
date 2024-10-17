import 'package:get/get.dart';
import 'package:swit/app/enums/online_status.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/usecases/get_my_profile_use_case.dart';
import 'package:swit/features/user/domain/usecases/update_my_profile_use_case.dart';

class UserViewModel extends GetxController {
  final UpdateMyProfileUseCase _updateMyProfileUseCase;
  final GetMyProfileUseCase _getMyProfileUseCase;

  UserViewModel({
    required GetMyProfileUseCase getMyProfileUseCase,
    required UpdateMyProfileUseCase updateMyProfileUseCase,
  }) :  _getMyProfileUseCase = getMyProfileUseCase,
        _updateMyProfileUseCase = updateMyProfileUseCase;


  late final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  // 파생된 옵저버블 속성들
  String get email => _user.value?.email ?? '';
  String get uid => _user.value?.uid ?? '';
  String get username => _user.value?.username ?? '아이디가 없습니다.';
  String get profileUrl => _user.value?.profileUrl ?? '';
  String get introduction => _user.value?.introduction ?? '';
  OnlineStatus get onlineStatus =>
      _user.value?.onlineStatus ?? OnlineStatus.offline;
  int get followerCount => _user.value?.followerCount ?? 0;
  int get followingCount => _user.value?.followingCount ?? 0;


  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  /* ------------------------------------------------------ */
  /* Life cycle ------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();
    loadMyProfile();
  }


  /* ------------------------------------------------------ */
  /* Get Functions ---------------------------------------- */
  /* ------------------------------------------------------ */
  Future<void> loadMyProfile() async {
    try {
      _isLoading.value = true;
      final User userProfile = await _getMyProfileUseCase.execute();
      _user.value = userProfile;
      update(); // GetX의 update 메서드 호출
    } catch (e) {
      print('Error loading profile: $e');
      // 에러 처리 로직 추가 (예: 스낵바 표시)
    } finally {
      _isLoading.value = false;
    }
  }

  /* ------------------------------------------------------ */
  /* Update Functions ------------------------------------- */
  /* ------------------------------------------------------ */
  Future<bool> updateMyProfile({String? username, String? introduction, String? profileUrl}) async {
    try {
      await _updateMyProfileUseCase.execute(
        userId: _user.value!.uid,
        username: username,
        introduction: introduction,
        profileUrl: profileUrl,
      );

      _user.value = User(
        uid: _user.value!.uid,
        email: _user.value!.email,
        username: username ?? _user.value!.username,
        profileUrl: profileUrl ?? _user.value!.profileUrl,
        introduction: introduction ?? _user.value!.introduction,
        onlineStatus: _user.value!.onlineStatus,
        followerCount: _user.value!.followerCount,
        followingCount: _user.value!.followingCount,
      );

      update();
      return true;
    } catch (e) {
      print('Error, Failed to update profile: $e');
      return false;
    }
  }

}
