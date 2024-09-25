import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/app/enums/online_status.dart';
import 'package:swit/features/mate/domain/usecases/get_mates_list_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_user_profile_use_case.dart';
import 'package:swit/features/mate/domain/usecases/search_mate_use_case.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:table_calendar/table_calendar.dart';

class MateViewModel extends GetxController {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetMatesListUseCase _getMatesListUseCase;
  final SearchMateUseCase _searchMateUseCase;
  MateViewModel(
      {required GetUserProfileUseCase getUserProfileUseCase,
      required GetMatesListUseCase getMatesListUseCase,
      required SearchMateUseCase searchMateUseCase})
      : _getUserProfileUseCase = getUserProfileUseCase,
        _getMatesListUseCase = getMatesListUseCase,
        _searchMateUseCase = searchMateUseCase;

  /* ------------------------------------------------------ */
  /* Tab Fields ------------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;

  /* ------------------------------------------------------ */
  /* Mate Fields ------------------------------------------ */
  /* ------------------------------------------------------ */
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  late final RxList<User> _pendingMateProfiles = <User>[].obs;
  late final RxList<User> _mateProfiles = <User>[].obs;
  List<User> get pendingMateProfiles => _pendingMateProfiles;
  List<User> get mateProfiles => _mateProfiles;
  // Methods for updating profile data are simplified
  // late final RxList<User> searchingProfiles = <User>[].obs;

  // 파생된 옵저버블 속성들
  String get email => _user.value?.email ?? '';
  String get uid => _user.value?.uid ?? '';
  String get username => _user.value?.username ?? '';
  String get profileUrl => _user.value?.profileUrl ?? '';
  String get introduction => _user.value?.introduction ?? '';
  OnlineStatus get onlineStatus =>
      _user.value?.onlineStatus ?? OnlineStatus.offline;

  late final Rx<TextEditingController> _searchController = TextEditingController().obs;
  TextEditingController get searchController => _searchController.value;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  @override
  void onClose() {
    _searchController.value.dispose();
    super.onClose();
  }

  /* ------------------------------------------------------ */
  /* Get Fields ------------------------------------------- */
  /* ------------------------------------------------------ */

  // 내 프로필 가져오기(업데이트)
  Future<void> loadUserProfile() async {
    final User userProfile = await _getUserProfileUseCase.execute();
    _user.value = userProfile;
  }

  Future<void> getMyMates() async {
    try {
      final myMates = await _getMatesListUseCase.execute();
      _mateProfiles.value = myMates;
      print("[ViewModel Get myMates] $myMates");
      update();
    } catch (e) {
      // 에러 처리 (예: 사용자에게 에러 메시지 표시)
      print('ViewModel Error fetching my mate profiles: $e');
    }
  }

  searchMate() async {
    try {
      final getData = await _searchMateUseCase.execute(_searchController.value.text);
      print('getData $getData');

      update();
    } catch (e) {
      print('ViewModel Error searching mate : $e');
    }
  }

  /* ------------------------------------------------------ */
  /* Update Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  void updateTapIndex(int newIndex) {
    _tabIndex.value = newIndex;
  }

  // 프로필 업데이트 메서드 (필요시 구현)
  Future<void> updateProfile(
      {String? newUsername, String? newEmail, String? newProfileUrl}) async {
    if (_user.value == null) return;

    try {
      // 여기에 실제 프로필 업데이트 로직 구현
      // 예: API 호출 또는 로컬 데이터베이스 업데이트
      final updatedUser = User(
        uid: _user.value!.uid,
        username: newUsername ?? _user.value!.username,
        email: newEmail ?? _user.value!.email,
        profileUrl: newProfileUrl ?? _user.value!.profileUrl,
        onlineStatus: _user.value!.onlineStatus,
      );

      // 실제로는 여기서 백엔드 API를 호출하여 업데이트를 수행해야 함
      // 예: await _userRepository.updateUser(updatedUser);

      _user.value = updatedUser;
    } catch (e) {
      print('Error updating profile: $e');
      // 에러 처리 로직
    }
  }
}
