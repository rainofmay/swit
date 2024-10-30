import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';

class LoginService extends GetxService {
  /* ------------------------------------------------------ */
  /* Variable Fields -------------------------------------- */
  /* ------------------------------------------------------ */
  static final _supabase = Supabase.instance.client;

  final RxBool _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  final Rx<User?> _currentUser = Rx<User?>(null);
  User? get currentUser => _currentUser.value;

  /* ------------------------------------------------------ */
  /* ViewModel Fields ------------------------------------- */
  /* ------------------------------------------------------ */
  UserViewModel? _userViewModel;
  MateViewModel? _mateViewModel;

  // ViewModel 등록
  void registerViewModels({
    required UserViewModel userViewModel,
    required MateViewModel mateViewModel,
  }) {
    _userViewModel = userViewModel;
    _mateViewModel = mateViewModel;
  }

  // 로그인 상태 변경 시 모든 ViewModel 업데이트
  Future<void> setLoginState(bool isLoggedIn) async {
    _isLoggedIn.value = isLoggedIn;

    if (isLoggedIn) {
      // 로그인 시 각 ViewModel 초기화
      await _userViewModel?.initializeProfile();
      await _mateViewModel?.initializeData();
    } else {
      // 로그아웃 시 데이터 클리어
      _userViewModel?.clearUserData();
      _mateViewModel?.clearMateData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _updateLoginState();
    // Auth 상태 변화 감지
    _supabase.auth.onAuthStateChange.listen((data) {
      _updateLoginState();
      _handleAuthStateChange(data.event);
    });
  }

  // 인증 상태 변화 처리
  Future<void> _handleAuthStateChange(AuthChangeEvent event) async {
    switch (event) {
      case AuthChangeEvent.signedIn:
        await _onSignedIn();
        break;
      case AuthChangeEvent.signedOut:
        await _onSignedOut();
        break;
      default:
        break;
    }
  }

  // 로그인 시 처리
  Future<void> _onSignedIn() async {
    try {
      // ViewModel들 초기화
      await _userViewModel?.initializeProfile();
      await _mateViewModel?.initializeData();
    } catch (e) {
      print('Error initializing ViewModels after sign in: $e');
    }
  }

  // 로그아웃 시 처리
  Future<void> _onSignedOut() async {
    _userViewModel?.clearUserData();
    _mateViewModel?.clearMateData();
  }

  void _updateLoginState() {
    _currentUser.value = _supabase.auth.currentUser;
    _isLoggedIn.value = _currentUser.value != null;
  }

  /* ------------------------------------------------------ */
  /* User Data Functions ---------------------------------- */
  /* ------------------------------------------------------ */
  String? getCurrentUserId() => currentUser?.id;

  String? getCurrentUserEmail() => currentUser?.email;

  Future<String?> getMyId() async {
    if (!isLoggedIn) {
      print("로그인이 안 되어있습니다.");
      return null;
    }

    try {
      final userEmail = getCurrentUserEmail();
      if (userEmail == null) return null;

      final response = await _supabase
          .from('users')
          .select('uid')
          .eq('email', userEmail)
          .single();
      return response['uid'];
    } catch (e) {
      print("Login service getMyId error: $e");
      return null;
    }
  }

  Future<String> getUsernameById(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select('username')
          .eq('uid', userId)
          .single();
      return response['username'] as String;
    } catch (e) {
      print('Error Login service getUsernameById: $e');
      return 'Unknown User';
    }
  }

  Future<Map<String, dynamic>> getUserById(String userId) async {
    try {
      return await _supabase
          .from('users')
          .select()
          .eq('uid', userId)
          .single();
    } catch (e) {
      print('Error Login service getUserById: $e');
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getUsersByIds(List<String> mateIds) async {
    try {
      final List<Map<String, dynamic>> userResponse = [];
      for (var mateId in mateIds) {
        final userData = await _supabase
            .from('users')
            .select()
            .eq('uid', mateId)
            .single();
        userResponse.add(userData);
      }
      return userResponse;
    } catch (e) {
      print('Error Login service getUsersByIds: $e');
      return [];
    }
  }

  Future<String?> getUserIdByEmail(String email) async {
    try {
      final response = await _supabase
          .from('users')
          .select('uid')
          .eq('email', email)
          .single();
      return response['id'];
    } catch (e) {
      print('Error Login service getUserIdByEmail: $e');
      return null;
    }
  }

  /* ------------------------------------------------------ */
  /* Auth Functions -------------------------------------- */
  /* ------------------------------------------------------ */
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      _updateLoginState();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }
}