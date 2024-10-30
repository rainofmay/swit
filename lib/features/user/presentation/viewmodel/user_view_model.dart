import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swit/app/enums/online_status.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/core/utils/user/profile_cache_manager.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/domain/usecases/get_my_profile_use_case.dart';
import 'package:swit/features/user/domain/usecases/update_my_profile_use_case.dart';

class UserViewModel extends GetxController {
  final UpdateMyProfileUseCase _updateMyProfileUseCase;
  final GetMyProfileUseCase _getMyProfileUseCase;
  final LoginService _loginService;
  final ImagePicker _imagePicker = ImagePicker();
  final ProfileCacheManager _cacheManager = ProfileCacheManager();

  UserViewModel({
    required GetMyProfileUseCase getMyProfileUseCase,
    required UpdateMyProfileUseCase updateMyProfileUseCase,
    required LoginService loginService,
  })
      : _getMyProfileUseCase = getMyProfileUseCase,
        _updateMyProfileUseCase = updateMyProfileUseCase,
        _loginService = loginService;



  late final Rx<User?> _user = Rx<User?>(null);
  final RxString _localImagePath = ''.obs; // 로컬 이미지 경로



  /* ------------------------------------------------------ */
  /* Getter Variables ------------------------------------- */
  /* ------------------------------------------------------ */
  User? get user => _loginService.isLoggedIn ? _user.value : null;
  String get profileUrl => _loginService.isLoggedIn
      ? (_localImagePath.value.isNotEmpty ? _localImagePath.value : _user.value?.profileUrl ?? '')
      : '';

  String get email => _loginService.isLoggedIn ? (_user.value?.email ?? '') : '';
  String get uid => _loginService.isLoggedIn ? (_user.value?.uid ?? '') : '';
  String get username => _loginService.isLoggedIn
      ? (_user.value?.username ?? '아이디가 없습니다.')
      : '로그인이 필요합니다';
  String get introduction => _loginService.isLoggedIn
      ? (_user.value?.introduction ?? '')
      : '';
  OnlineStatus get onlineStatus => _loginService.isLoggedIn
      ? (_user.value?.onlineStatus ?? OnlineStatus.offline)
      : OnlineStatus.offline;
  int get followerCount => _loginService.isLoggedIn
      ? (_user.value?.followerCount ?? 0)
      : 0;
  int get followingCount => _loginService.isLoggedIn
      ? (_user.value?.followingCount ?? 0)
      : 0;

  /* ------------------------------------------------------ */
  /* Life cycle ------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();
    // 로그인 상태 감시
    if (_loginService.isLoggedIn) {
      initializeProfile();
    }
  }

  // 유저 데이터 초기화 메서드


  /* ------------------------------------------------------ */
  /* Get Functions ---------------------------------------- */
  /* ------------------------------------------------------ */
  Future<void> initializeProfile() async {
    if (!_loginService.isLoggedIn) return;

    try {
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
    }
  }

  /* ------------------------------------------------------ */
  /* Update Functions ------------------------------------- */
  /* ------------------------------------------------------ */

  Future<void> updateProfileImage(ImageSource source) async {
    if (!_loginService.isLoggedIn ) return;

    try {

      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 600,
        maxHeight: 600,
        preferredCameraDevice: CameraDevice.front,
      );

      if (pickedFile == null || _user.value == null) return;

      // 이미지 파일 유효성 검사
      final File imageFile = File(pickedFile.path);

      if (!await imageFile.exists()) {
        throw Exception('Selected image file does not exist');
      }

      // 파일 확장자 확인
      final String extension = pickedFile.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png'].contains(extension)) {
        Get.snackbar('오류', 'JPG 또는 PNG 형식의 이미지만 사용 가능합니다');
        return;
      }

      // 이미지 크기 제한
      final fileSize = await imageFile.length();
      if (fileSize > 5 * 1024 * 1024) {
        Get.snackbar('오류', '이미지 크기가 너무 큽니다 (최대 5MB)');
        return;
      }

      // 즉시 UI 업데이트를 위한 로컬 경로 설정
      _localImagePath.value = imageFile.path;

      try {
        // 프로필 업데이트 수행
        await _updateMyProfileUseCase.execute(
          userId: _user.value!.uid,
          profileImage: imageFile,
        );

        // 기존 캐시 삭제
        if (_user.value?.profileUrl != null && _user.value!.profileUrl.isNotEmpty) {
          await _cacheManager.removeFile(_user.value!.profileUrl);
        }


      } catch (e) {
        throw Exception('Failed to update profile image: $e');
      }

    } catch (e) {
      print('Profile image update error: $e');
      _localImagePath.value = '';

    }
  }


  Future<bool> updateMyProfile(
      {String? username, String? introduction, String? profileUrl}) async {
    if (!_loginService.isLoggedIn || user == null) return false;

    try {
      await _updateMyProfileUseCase.execute(
        userId: _user.value!.uid,
        username: username,
        introduction: introduction,
        profileUrl: profileUrl,
      );

      final updatedProfile = await _getMyProfileUseCase.execute();
      _user.value = updatedProfile;

      return true;
    } catch (e) {
      print('Error, Failed to update profile: $e');
      return false;
    }
  }

  /* ------------------------------------------------------ */
  /* Delete Functions ------------------------------------- */
  /* ------------------------------------------------------ */
  void clearUserData() {
    _user.value = null;
    _localImagePath.value = '';
  }
}