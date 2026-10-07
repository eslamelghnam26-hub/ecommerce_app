import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/core/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final RxList<Product> favorites = <Product>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (_authService.isLoggedIn) {
      loadFavorites();
    }
  }

  Future<void> loadFavorites() async {
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('favorites_${_authService.userId}');
      if (data != null) {
        final items = jsonDecode(data) as List;
        favorites.value = items
            .map((e) => Product.fromJson(jsonDecode(e.toString())))
            .toList();
      }
    } catch (e) {
      // ignore
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(Product product) async {
    final index = favorites.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      favorites.add(product);
    }
    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    if (!_authService.isLoggedIn) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = favorites
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setString(
      'favorites_${_authService.userId}',
      jsonEncode(data),
    );
  }

  bool isFavorite(Product product) {
    return favorites.any((p) => p.id == product.id);
  }

  void clearFavorites() {
    favorites.clear();
  }
}