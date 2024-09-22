import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/app/enums/online_status.dart';
import 'package:swit/features/mate/domain/usecases/get_user_profile_use_case.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:table_calendar/table_calendar.dart';

class MateViewModel extends GetxController {
  final GetUserProfileUseCase _getUserProfileUseCase;
  MateViewModel(this._getUserProfileUseCase);

  late final RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;

  /* -- Calendar -- */
  late final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  late final Rx<DateTime> _focusedDate = DateTime.now().obs;
  DateTime get focusedDate => _focusedDate.value;

  final Rx<CalendarFormat> _calendarFormat = CalendarFormat.month.obs;
  CalendarFormat get calendarFormat => _calendarFormat.value;

  /* -- Post it -- */
  late final Rx<TextEditingController> _postItController = TextEditingController().obs;
  TextEditingController get postItController => _postItController.value;
  late final RxString _postIt = ''.obs;
  String get postIt => _postIt.value;

  /* -- Mates -- */
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  // 파생된 옵저버블 속성들
  String get email => _user.value?.email ?? '';
  String get uid => _user.value?.uid ?? '';
  String get username => _user.value?.username ?? '테스트';
  String get profileUrl => _user.value?.profileUrl ?? '';
  OnlineStatus get onlineStatus => _user.value?.onlineStatus ?? OnlineStatus.offline;


  @override
  void onInit() {
    super.onInit();
    _postItController.value.addListener(updatePostIt);
    loadUserProfile();

  }

  @override
  void onClose() {

    super.onClose();
  }

  /* ----------- Functions ----------- */

  /* -- get -- */
  // 내 프로필 가져오기(업데이트)
  Future<void> loadUserProfile() async {
      final User userProfile = await _getUserProfileUseCase.getUserProfile();
      _user.value = userProfile;
  }

  /* -- update -- */
  void updateTapIndex(int newIndex) {
    _tabIndex.value = newIndex;
  }

  void updateSelectedDate(DateTime selectedDate) {
    _selectedDate.value = selectedDate;
  }

  void updateFocusedDate(DateTime focusedDate) {
    _focusedDate.value = focusedDate;
  }

  void updatePostIt() {
    _postIt.value = _postItController.value.text;
  }

  // 프로필 업데이트 메서드 (필요시 구현)
  Future<void> updateProfile({
    String? newUsername,
    String? newEmail,
    String? newProfileUrl
  }) async {
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