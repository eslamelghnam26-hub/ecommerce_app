import 'package:ecommerce_app/app/theme/app_theme.dart';
import 'package:ecommerce_app/features/products/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageCategoriesScreen extends StatelessWidget {
  ManageCategoriesScreen({super.key});

  final TextEditingController categoryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'إدارة التصنيفات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () {
          final categories = productController.categories;
          return Column(
            children: [
              // Add category form
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: categoryController,
                          decoration: const InputDecoration(
                            labelText: 'اسم التصنيف الجديد',
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'الاسم مطلوب' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Get.snackbar(
                              'تم بنجاح',
                              'تم إضافة التصنيف',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.success,
                              colorText: Colors.white,
                            );
                            categoryController.clear();
                          }
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(14),
                        ),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: categories.isEmpty
                    ? Center(
                        child: Text(
                          'لا توجد تصنيفات',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.category,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    category.name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${category.productCount} منتجات',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text('حذف التصنيف'),
                                        content: Text(
                                          'هل أنت متأكد من حذف "${category.name}"؟',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: const Text('إلغاء'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.snackbar(
                                                'تم',
                                                'تم حذف التصنيف',
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                              );
                                            },
                                            child: const Text(
                                              'حذف',
                                              style: TextStyle(
                                                color: AppColors.error,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}