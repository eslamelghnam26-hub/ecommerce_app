import 'package:ecommerce_app/core/api/api_client.dart';
import 'package:ecommerce_app/core/models/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final ApiClient _apiClient = Get.find<ApiClient>();

  final RxList<Order> orders = <Order>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await _apiClient.get('/orders');
      final data = response.data;

      final List<dynamic> items = data is List
          ? data
          : (data['data'] ?? data['orders'] ?? []);

      orders.value = items
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      error.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> placeOrder(Map<String, dynamic> orderData) async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await _apiClient.post(
        '/orders',
        data: orderData,
      );
      final data = response.data;

      if (data is Map<String, dynamic> && data['order'] != null) {
        final order = Order.fromJson(data['order'] as Map<String, dynamic>);
        orders.insert(0, order);
      }

      return true;
    } catch (e) {
      error.value = e.toString().replaceAll('Exception: ', '');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelOrder(int orderId) async {
    isLoading.value = true;
    try {
      await _apiClient.post('/orders/$orderId/cancel');
      await fetchOrders();
    } catch (e) {
      error.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}