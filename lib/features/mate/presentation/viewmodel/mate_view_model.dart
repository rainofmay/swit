
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/app/enums/online_status.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/mate/domain/usecases/follow_mate_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_follower_list_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_following_list_use_case.dart';
import 'package:swit/features/mate/domain/usecases/search_mate_use_case.dart';
import 'package:swit/features/mate/domain/usecases/unfollow_mate_use_case.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';

class MateViewModel extends GetxController {
  final UserViewModel _userViewModel;
  final SearchMateUseCase _searchMateUseCase;
  final FollowMateUseCase _followMateUseCase;
  final GetFollowingListUseCase _getFollowingListUseCase;
  final GetFollowerListUseCase _getFollowerListUseCase;
  final UnfollowMateUseCase _unfollowMateUseCase;
  final LoginService _loginService;

  MateViewModel(
      {  required UserViewModel userViewModel,
        required SearchMateUseCase searchMateUseCase,
        required FollowMateUseCase followMateUseCase,
        required GetFollowingListUseCase getFollowingListUseCase,
        required GetFollowerListUseCase getFollowerListUseCase,
        required UnfollowMateUseCase unfollowMateUseCase,
        required LoginService loginService,
      })
      :  _userViewModel = userViewModel,
        _searchMateUseCase = searchMateUseCase,
        _followMateUseCase = followMateUseCase,
        _getFollowingListUseCase = getFollowingListUseCase,
        _getFollowerListUseCase = getFollowerListUseCase,
        _unfollowMateUseCase = unfollowMateUseCase,
        _loginService = loginService {
        // 생성 시 LoginService에 자신을 등록
        _loginService.registerViewModels(
          userViewModel: _userViewModel,
          mateViewModel: this,
        );
      }

  /* ------------------------------------------------------ */
  /* Mate Fields ------------------------------------------ */
  /* ------------------------------------------------------ */

  late final Rx<User?> _searchedMate = Rx<User?>(null);
  User? get searchedMate => _searchedMate.value;
  late final Rx<TextEditingController> _searchController = TextEditingController().obs;
  TextEditingController get searchController => _searchController.value;

  bool isCurrentUser(User? searchedUser) {
    return searchedUser != null && searchedUser.uid == _loginService.currentUser?.id;
  }

  bool isFollowing(User? selectedUser) {
    return selectedUser != null && _followingList.any((user) => user.uid == selectedUser.uid);
  }

  // 내가 팔로잉하고 있는 메이트 리스트
  late final RxList<User> _followingList = <User>[].obs;
  List<User> get followingList => _followingList;

  // 나를 팔로우 하는 메이트 리스트
  late final RxList<User> _followerList = <User>[].obs;
  List<User> get followerList => _followerList;

  /* ------------------------------------------------------ */
  /* Life Cycles ------------------------------------------ */
  /* ------------------------------------------------------ */

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  // 데이터 초기화 메서드
  Future<void> initializeData() async {
    if (!_loginService.isLoggedIn) return;

    await getFollowingList();
    await getFollowerList();
  }

  @override
  void onClose() {
    _searchController.value.clear();
    _searchController.value.dispose();
    super.onClose();
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

  Future<void> getFollowerList() async {
    try {
      final followers = await _getFollowerListUseCase.execute();
      _followerList.value = followers;

    } catch (e) {
      print('Mate ViewModel Error get follower list: $e');
    }
  }

  Future<void> followMate() async {
   await _followMateUseCase.execute(_searchedMate.value!.uid);

   // 팔로우 성공 후 팔로잉 리스트에 추가
   if (!_followingList.contains(_searchedMate.value)) {
     _followingList.add(_searchedMate.value!);
   }
   // 팔로잉 성공 후 내 팔로잉 수 최신화
   await _userViewModel.initializeProfile();

  }

  Future<void> unfollowMate(String unfollowedId) async {
    try {
      await _unfollowMateUseCase.execute(unfollowedId);
      // 팔로잉 목록에서 해당 사용자 제거
      _followingList.removeWhere((user) => user.uid == unfollowedId);

      // 언팔 성공 후 내 팔로잉 수 최신화
      await _userViewModel.initializeProfile();

    } catch (e) {
      print('Error unfollowing mate: $e');
      // 에러 처리 (예: 스낵바 표시)
    }
  }

  // 팔로잉 리스트를 새로고침하는 메서드
  Future<void> refreshFollowingList() async {
    await getFollowingList();
    update();
  }

  /* ------------------------------------------------------ */
  /* Delete Functions ------------------------------------- */
  /* ------------------------------------------------------ */
  void clearMateData() {
    _followingList.clear();
    _followerList.clear();
    _searchedMate.value = null;
    _searchController.value.clear();
  }
}
