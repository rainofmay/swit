
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/app/enums/online_status.dart';
import 'package:swit/features/mate/domain/usecases/follow_mate_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_following_list_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_user_profile_use_case.dart';
import 'package:swit/features/mate/domain/usecases/search_mate_use_case.dart';
import 'package:swit/features/mate/domain/usecases/unfollow_mate_use_case.dart';
import 'package:swit/features/user/domain/entities/user.dart';

class MateViewModel extends GetxController {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final SearchMateUseCase _searchMateUseCase;
  final FollowMateUseCase _followMateUseCase;
  final GetFollowingListUseCase _getFollowingListUseCase;
  final UnfollowMateUseCase _unfollowMateUseCase;

  MateViewModel(
      {required GetUserProfileUseCase getUserProfileUseCase,
      required SearchMateUseCase searchMateUseCase,
      required GetFollowingListUseCase getFollowingListUseCase,
      required FollowMateUseCase followMateUseCase,
      required UnfollowMateUseCase unfollowMateUseCase,
      })
      : _getUserProfileUseCase = getUserProfileUseCase,
        _searchMateUseCase = searchMateUseCase,
        _getFollowingListUseCase = getFollowingListUseCase,
        _followMateUseCase = followMateUseCase,
        _unfollowMateUseCase = unfollowMateUseCase
  ;

  /* ------------------------------------------------------ */
  /* Tab Fields ------------------------------------------- */
  /* ------------------------------------------------------ */
  final RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;

  /* ------------------------------------------------------ */
  /* Profile Fields --------------------------------------- */
  /* ------------------------------------------------------ */

  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;


  /* ------------------------------------------------------ */
  /* Mate Fields ------------------------------------------ */
  /* ------------------------------------------------------ */

  late final Rx<User?> _searchedMate = Rx<User?>(null);
  User? get searchedMate => _searchedMate.value;
  late final Rx<TextEditingController> _searchController = TextEditingController().obs;
  TextEditingController get searchController => _searchController.value;

  bool isCurrentUser(User? searchedUser) {
    return searchedUser != null && searchedUser.uid == _user.value?.uid;
  }

  bool isFollowing(User? selectedUser) {
    return selectedUser != null && _followingList.any((user) => user.uid == selectedUser.uid);
  }

  // 내가 팔로잉하고 있는 메이트 리스트
  late final RxList<User> _followingList = <User>[].obs;
  List<User> get followingList => _followingList;



  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    getFollowingList();
  }

  @override
  void onClose() {
    _searchController.value.clear();
    _searchController.value.dispose();
    super.onClose();
  }

  /* ------------------------------------------------------ */
  /* Tap Functions----------------------------------------- */
  /* ------------------------------------------------------ */
  void updateTapIndex(int newIndex) {
    _tabIndex.value = newIndex;
  }

  /* ------------------------------------------------------ */
  /* Profile Functions ------------------------------------ */
  /* ------------------------------------------------------ */

  // 내 프로필 가져오기(업데이트)
  Future<void> loadUserProfile() async {
    final User userProfile = await _getUserProfileUseCase.execute();
    _user.value = userProfile;
  }


  /* ------------------------------------------------------ */
  /* Mate Functions --------------------------------------- */
  /* ------------------------------------------------------ */

  Future<void> searchMate() async {
    try {
      final searchedData = await _searchMateUseCase.execute(_searchController.value.text);
      if (searchedData.isNotEmpty) {
        _searchedMate.value = searchedData.first;
      } else {
        _searchedMate.value = null; // 검색 결과가 없을 때 null로 설정
      }
      update();
    } catch (e) {
      print('ViewModel Error searching mate : $e');
      _searchedMate.value = null; // 에러 발생 시에도 null로 설정
      update();
    }
  }

  void initSearch() {
    _searchedMate.value = null;
    _searchController.value.text = '';
  }

  Future<void> getFollowingList() async {
    try {
      final following = await _getFollowingListUseCase.execute();
      _followingList.value = following;
      update();
    } catch (e) {
      print('Mate ViewModel Error get following list: $e');
    }
  }

  Future<void> followMate() async {
   await _followMateUseCase.execute(_searchedMate.value!.uid);

   // 팔로우 성공 후 팔로잉 리스트에 추가
   if (!_followingList.contains(_searchedMate.value)) {
     _followingList.add(_searchedMate.value!);
   }
   // 팔로잉 성공 후 실행할 함수
  }

  Future<void> unfollowMate(String unfollowedId) async {
    try {
      await _unfollowMateUseCase.execute(unfollowedId);
      // 팔로잉 목록에서 해당 사용자 제거
      _followingList.removeWhere((user) => user.uid == unfollowedId);
      update();
    } catch (e) {
      print('Error unfollowing mate: $e');
      // 에러 처리 (예: 스낵바 표시)
    }
  }

}
