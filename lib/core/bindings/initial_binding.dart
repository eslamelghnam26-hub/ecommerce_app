import 'package:ecommerce_app/core/api/api_client.dart';
import 'package:ecommerce_app/core/services/auth_service.dart';
import 'package:ecommerce_app/features/auth/auth_controller.dart';
import 'package:ecommerce_app/features/cart/cart_controller.dart';
import 'package:ecommerce_app/features/favorites/favorites_controller.dart';
import 'package:ecommerce_app/features/orders/order_controller.dart';
import 'package:ecommerce_app/features/products/product_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<ApiClient>(ApiClient(Get.find<AuthService>()), permanent: true);

    Get.put<AuthController>(AuthController());
    Get.put<ProductController>(ProductController());
    Get.put<CartController>(CartController());
    Get.put<FavoritesController>(FavoritesController());
    Get.put<OrderController>(OrderController());
  }
}