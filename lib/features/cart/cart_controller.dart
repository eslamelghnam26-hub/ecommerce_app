import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/core/models/cart_item.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;

  double get subtotal => items.fold(0, (sum, item) => sum + item.subtotal);
  double get shippingCost => subtotal > 0 && subtotal < 500 ? 25 : 0; // Free over 500
  double get tax => subtotal * 0.15;
  double get total => subtotal + shippingCost + tax;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;

  CartItem? findItem(int productId) {
    return items.firstWhereOrNull((item) => item.product.id == productId);
  }

  void addToCart(Product product, {int quantity = 1}) {
    final existing = findItem(product.id ?? 0);
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }
    Get.snackbar(
      'Cart',
      product.name + ' added to cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
    items.refresh();
  }

  void removeFromCart(int productId) {
    items.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(int productId, int quantity) {
    final item = findItem(productId);
    if (item != null) {
      if (quantity <= 0) {
        removeFromCart(productId);
      } else {
        item.quantity = quantity;
        items.refresh();
      }
    }
  }

  void incrementQuantity(int productId) {
    final item = findItem(productId);
    if (item != null) {
      item.quantity++;
      items.refresh();
    }
  }

  void decrementQuantity(int productId) {
    final item = findItem(productId);
    if (item != null) {
      if (item.quantity <= 1) {
        removeFromCart(productId);
      } else {
        item.quantity--;
        items.refresh();
      }
    }
  }

  void clearCart() {
    items.clear();
  }
}
