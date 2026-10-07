import 'package:ecommerce_app/app/theme/app_theme.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/cart/cart_controller.dart';
import 'package:ecommerce_app/features/orders/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _paymentMethod = 'cash_on_delivery'.obs;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final orderController = Get.find<OrderController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'إتمام الشراء',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'عنوان الشحن',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: nameController,
                  label: 'الاسم الكامل',
                  prefixIcon: Icons.person_outline,
                  validator: (value) =>
                      value!.isEmpty ? 'الاسم مطلوب' : null,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: phoneController,
                  label: 'رقم الهاتف',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: (value) =>
                      value!.isEmpty ? 'رقم الهاتف مطلوب' : null,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: addressController,
                  label: 'العنوان',
                  maxLines: 2,
                  prefixIcon: Icons.home_outlined,
                  validator: (value) =>
                      value!.isEmpty ? 'العنوان مطلوب' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: cityController,
                        label: 'المدينة',
                        prefixIcon: Icons.location_city_outlined,
                        validator: (value) =>
                            value!.isEmpty ? 'مطلوب' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: noteController,
                  label: 'ملاحظات (اختياري)',
                  maxLines: 2,
                  prefixIcon: Icons.notes_outlined,
                ),
                const SizedBox(height: 24),
                const Text(
                  'طريقة الدفع',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                _PaymentMethodTile(
                  title: 'الدفع عند الاستلام',
                  subtitle: 'ادفع نقداً عند استلام طلبك',
                  icon: Icons.payments_outlined,
                  isSelected: _paymentMethod.value == 'cash_on_delivery',
                  onTap: () => _paymentMethod.value = 'cash_on_delivery',
                ),
                const SizedBox(height: 8),
                _PaymentMethodTile(
                  title: 'بطاقة ائتمان',
                  subtitle: 'ادفع أونلاين بأمان',
                  icon: Icons.credit_card,
                  isSelected: _paymentMethod.value == 'card',
                  onTap: () => _paymentMethod.value = 'card',
                ),
                if (_paymentMethod.value == 'card') ...[
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: cardNumberController,
                    label: 'رقم البطاقة',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.credit_card_outlined,
                    validator: (value) {
                      if (value!.isEmpty) return 'رقم البطاقة مطلوب';
                      if (value.replaceAll(' ', '').length < 16) {
                        return 'رقم بطاقة غير صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: TextEditingController(),
                          label: 'تاريخ الانتهاء',
                          keyboardType: TextInputType.datetime,
                          prefixIcon: Icons.calendar_month_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomTextField(
                          controller: TextEditingController(),
                          label: 'CVV',
                          keyboardType: TextInputType.number,
                          prefixIcon: Icons.lock_outline,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                const Text(
                  'ملخص الطلب',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _OrderRow(
                        label: 'عدد العناصر',
                        value: '${cartController.itemCount}',
                      ),
                      const SizedBox(height: 8),
                      _OrderRow(
                        label: 'المجموع الفرعي',
                        value:
                            '${cartController.subtotal.toStringAsFixed(0)} ر.س',
                      ),
                      const SizedBox(height: 8),
                      _OrderRow(
                        label: 'الشحن',
                        value: cartController.shippingCost == 0
                            ? 'مجاني'
                            : '${cartController.shippingCost.toStringAsFixed(0)} ر.س',
                      ),
                      const SizedBox(height: 8),
                      _OrderRow(
                        label: 'الضريبة',
                        value:
                            '${cartController.tax.toStringAsFixed(0)} ر.س',
                      ),
                      const Divider(height: 20),
                      _OrderRow(
                        label: 'الإجمالي',
                        value:
                            '${cartController.total.toStringAsFixed(0)} ر.س',
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'تأكيد الطلب',
                  isLoading: orderController.isLoading.value,
                  icon: Icons.check_circle_outline,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final orderData = {
                        'shipping_address':
                            '${addressController.text}, ${cityController.text}, ${nameController.text}, ${phoneController.text}',
                        'payment_method': _paymentMethod.value,
                        'note': noteController.text,
                        'subtotal': cartController.subtotal,
                        'shipping_cost': cartController.shippingCost,
                        'tax': cartController.tax,
                        'total': cartController.total,
                        'items': cartController.items.map((item) => {
                              'product_id': item.product.id,
                              'quantity': item.quantity,
                            }).toList(),
                      };

                      final success = await orderController.placeOrder(orderData);
                      if (success) {
                        cartController.clearCart();
                        Get.offAllNamed('/order-success');
                      } else {
                        Get.snackbar(
                          'خطأ',
                          orderController.error.value,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.error,
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey.shade600,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _OrderRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.primary : Colors.black87,
          ),
        ),
      ],
    );
  }
}