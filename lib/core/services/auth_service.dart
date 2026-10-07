import 'package:ecommerce_app/core/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String? _token;
  String? _userId;
  String? _userRole;
  bool _isLoggedIn = false;

  String? get token => _token;
  String? get userId => _userId;
  String? get userRole => _userRole;
  bool get isLoggedIn => _isLoggedIn;
  bool get isAdmin => _userRole == 'admin';

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(AppConstants.tokenKey);
    _userId = prefs.getString('user_id');
    _userRole = prefs.getString('user_role');
    _isLoggedIn = _token != null;
  }

  Future<void> setUser({
    required String token,
    required String userId,
    required String role,
  }) async {
    _token = token;
    _userId = userId;
    _userRole = role;
    _isLoggedIn = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.tokenKey, token);
    await prefs.setString('user_id', userId);
    await prefs.setString('user_role', role);
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _userRole = null;
    _isLoggedIn = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove('user_id');
    await prefs.remove('user_role');
  }
}
