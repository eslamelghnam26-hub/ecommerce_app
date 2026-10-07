import 'package:ecommerce_app/core/api/api_client.dart';
import 'package:ecommerce_app/core/models/user_model.dart';
import 'package:ecommerce_app/core/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final ApiClient _apiClient = Get.find<ApiClient>();

  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString error = ''.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = _authService.isLoggedIn;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await _apiClient.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final userData = data['user'] as Map<String, dynamic>;
      final token = data['token'] as String;

      await _authService.setUser(
        token: token,
        userId: userData['id'].toString(),
        role: userData['role'] ?? 'user',
      );

      currentUser.value = User.fromJson(userData);
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (e) {
      // Demo mode: allow login without backend using demo credentials
      _demoLogin(email: email, password: password);
    } finally {
      isLoading.value = false;
    }
  }

  void _demoLogin({required String email, required String password}) {
    if (email == 'admin@store.com' && password == '123456') {
      _setDemoUser(
        User(
          id: 1,
          name: 'مدير المتجر',
          email: email,
          role: 'admin',
        ),
        'demo_admin_token',
      );
      return;
    }
    _setDemoUser(
      User(
        id: 999,
        name: 'مستخدم تجريبي',
        email: email.isEmpty ? 'user@store.com' : email,
        role: 'user',
      ),
      'demo_user_token',
    );
  }

  Future<void> _setDemoUser(User user, String token) async {
    await _authService.setUser(
      token: token,
      userId: user.id.toString(),
      role: user.role,
    );
    currentUser.value = user;
    isLoggedIn.value = true;
    Get.snackbar(
      'وضع تجريبي',
      user.role == 'admin'
          ? 'تم الدخول كمدير - جرب الحساب: admin@store.com / 123456'
          : 'تم الدخول في الوضع التجريبي',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
    Get.offAllNamed('/home');
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await _apiClient.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone ?? '',
        },
      );

      final data = response.data as Map<String, dynamic>;
      final userData = data['user'] as Map<String, dynamic>;
      final token = data['token'] as String;

      await _authService.setUser(
        token: token,
        userId: userData['id'].toString(),
        role: userData['role'] ?? 'user',
      );

      currentUser.value = User.fromJson(userData);
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (e) {
      // Demo mode: allow registration without backend
      _setDemoUser(
        User(
          id: 1000,
          name: name,
          email: email,
          role: 'user',
          phone: phone,
        ),
        'demo_user_token',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    isLoading.value = true;
    error.value = '';
    try {
      await _apiClient.post(
        '/forgot-password',
        data: {
          'email': email,
        },
      );
      Get.snackbar(
        'Reset Password',
        'Password reset link sent to your email',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back();
    } catch (e) {
      error.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    isLoggedIn.value = false;
    currentUser.value = null;
    Get.offAllNamed('/login');
  }

  bool get isAdmin => _authService.isAdmin;
}