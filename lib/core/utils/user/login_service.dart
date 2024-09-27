import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService extends GetxService {
  static final _supabase = Supabase.instance.client;

  final RxBool _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;
  final Rx<User?> _currentUser = Rx<User?>(null);
  User? get currentUser => _currentUser.value;

  @override
  void onInit() {
    super.onInit();
    _updateLoginState();
    _supabase.auth.onAuthStateChange.listen((data) {
      _updateLoginState();
    });
  }

  void _updateLoginState() {
    _currentUser.value = _supabase.auth.currentUser;
    _isLoggedIn.value = _currentUser.value != null;
  }

  String? getCurrentUserId() {
    return currentUser?.id;
  }

  String? getCurrentUserEmail() {
    return currentUser?.email;
  }

  Future<String?> getMyId() async {
    if (!isLoggedIn) {
      print("로그인이 안 되어있습니다.");
      return null;
    }
    final userEmail = getCurrentUserEmail();
    if (userEmail != null) {
      final response = await _supabase
          .from('users')
          .select('uid')
          .eq('email', userEmail)
          .single();
      return response['uid'];
    } else {
      print("Login service getCurrentUserId: error");
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
      final userData = await _supabase
          .from('users')
          .select()
          .eq('uid', userId)
          .single();
      return userData;
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
    }
    return null;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    _updateLoginState();
  }
}