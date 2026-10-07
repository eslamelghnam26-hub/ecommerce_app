import 'package:ecommerce_app/app/theme/app_theme.dart';
import 'package:ecommerce_app/core/models/order_model.dart';
import 'package:ecommerce_app/features/orders/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageOrdersScreen extends StatelessWidget {
  const ManageOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'إدارة الطلبات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () {
          if (orderController.isLoading.value &&
              orderController.orders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderController.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد طلبات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orderController.orders.length,
            itemBuilder: (context, index) {
              final order = orderController.orders[index];
              return _AdminOrderCard(order: order);
            },
          );
        },
      ),
    );
  }
}

class _AdminOrderCard extends StatelessWidget {
  final Order order;

  const _AdminOrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (order.status) {
      'pending' => (Colors.orange, 'قيد الانتظار'),
      'processing' => (Colors.blue, 'قيد المعالجة'),
      'shipped' => (Colors.purple, 'تم الشحن'),
      'delivered' => (Colors.green, 'تم التسليم'),
      'cancelled' => (Colors.red, 'ملغي'),
      _ => (Colors.grey, 'غير محدد'),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderNumber ?? '${order.id ?? ''}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            order.shippingAddress,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${order.items.length} عناصر',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                '${order.total.toStringAsFixed(0)} ر.س',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: order.status,
            initialValue: order.status,
            decoration: InputDecoration(
              labelText: 'تحديث الحالة',
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: const [
              DropdownMenuItem(
                value: 'pending',
                child: Text('قيد الانتظار'),
              ),
              DropdownMenuItem(
                value: 'processing',
                child: Text('قيد المعالجة'),
              ),
              DropdownMenuItem(
                value: 'shipped',
                child: Text('تم الشحن'),
              ),
              DropdownMenuItem(
                value: 'delivered',
                child: Text('تم التسليم'),
              ),
              DropdownMenuItem(
                value: 'cancelled',
                child: Text('ملغي'),
              ),
            ],
            onChanged: (value) {
              Get.snackbar(
                'تم تحديث الحالة',
                'تم تحديث حالة الطلب إلى $label',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.success,
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
    );
  }
}