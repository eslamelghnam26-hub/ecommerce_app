class AppConstants {
  static const String baseUrl =
      'http://192.168.1.19:8000/api'; // PC LAN IP for real phone tests
  // Change to your actual server URL for production
  // static const String baseUrl = 'https://your-domain.com/api';

  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'app_language';
  static const String themeKey = 'app_theme';
  static const String onboardingKey = 'has_seen_onboarding';
  static const String cartKey = 'cart_data';
  static const String favoritesKey = 'favorites_data';
}
