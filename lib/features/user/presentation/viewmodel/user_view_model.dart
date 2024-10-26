import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swit/app/enums/online_status.dart';
import 'package:swit/core/utils/user/profile_cache_manager.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/usecases/get_my_profile_use_case.dart';
import 'package:swit/features/user/domain/usecases/update_my_profile_use_case.dart';

class UserViewModel extends GetxController {
  final UpdateMyProfileUseCase _updateMyProfileUseCase;
  final GetMyProfileUseCase _getMyProfileUseCase;
  final ImagePicker _imagePicker = ImagePicker();
  final ProfileCacheManager _cacheManager = ProfileCacheManager();

  UserViewModel({
    required GetMyProfileUseCase getMyProfileUseCase,
    required UpdateMyProfileUseCase updateMyProfileUseCase,
  })
      : _getMyProfileUseCase = getMyProfileUseCase,
        _updateMyProfileUseCase = updateMyProfileUseCase;


  late final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  // 파생된 옵저버블 속성들
  final RxString _localImagePath = ''.obs; // 로컬 이미지 경로
  String get email => _user.value?.email ?? '';
  String get uid => _user.value?.uid ?? '';
  String get username => _user.value?.username ?? '아이디가 없습니다.';
  String get profileUrl {
    if (_localImagePath.value.isNotEmpty) {
      return _localImagePath.value;
    }
    return _user.value?.profileUrl ?? '';  // 타임스탬프 제거
  }

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
    preloadMyProfileImage();
  }


  /* ------------------------------------------------------ */
  /* Get Functions ---------------------------------------- */
  /* ------------------------------------------------------ */
  Future<void> loadMyProfile() async {
    try {
      _isLoading.value = true;
      final User userProfile = await _getMyProfileUseCase.execute();
      _user.value = userProfile;

      // 프로필 이미지 프리로드
      if (userProfile.profileUrl.isNotEmpty) {
        unawaited(_cacheManager.preloadImages([userProfile.profileUrl]));
      }

    } catch (e) {
      print('Error loading profile: $e');
      // 에러 처리 로직 추가 (예: 스낵바 표시)
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> preloadMyProfileImage() async {
    if (profileUrl.isNotEmpty) {
      await _cacheManager.downloadFile(profileUrl);
    }
  }
  /* ------------------------------------------------------ */
  /* Update Functions ------------------------------------- */
  /* ------------------------------------------------------ */

  Future<void> updateProfileImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 600,
        maxHeight: 600,
      );

      if (image == null || _user.value == null) return;

      // 1. 즉시 로컬 이미지로 UI 업데이트
      _localImagePath.value = image.path;

      // 2. 백그라운드에서 이미지 업로드 및 프로필 업데이트
      await _updateMyProfileUseCase.execute(
          userId: _user.value!.uid,
          profileImage: File(image.path)
      );

      // 3. 캐시 삭제 및 서버 데이터로 동기화
      final oldUrl = _user.value?.profileUrl;
      if (oldUrl != null) {
        await _cacheManager.removeFile(oldUrl);
      }

      // 4. 프로필 새로고침
      await loadMyProfile();
      _localImagePath.value = '';  // 서버 이미지로 전환

    } catch (e) {
      print('Error updating profile image: $e');
      Get.snackbar('오류', '이미지 업데이트에 실패했습니다');
      _localImagePath.value = '';  // 에러 시 로컬 이미지 초기화
    }
  }

  Future<bool> updateMyProfile(
      {String? username, String? introduction, String? profileUrl}) async {
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