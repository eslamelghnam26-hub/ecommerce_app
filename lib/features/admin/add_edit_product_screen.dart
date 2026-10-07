import 'package:ecommerce_app/app/theme/app_theme.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({super.key});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _nameArController;
  late TextEditingController _priceController;
  late TextEditingController _oldPriceController;
  late TextEditingController _stockController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  String? _selectedCategory;
  bool _isEditing = false;
  bool _isFeatured = false;
  bool _isBestSeller = false;
  bool _isNew = false;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    if (arguments != null && arguments is Product) {
      _isEditing = true;
      final product = arguments;
      _nameController = TextEditingController(text: product.name);
      _nameArController = TextEditingController(text: product.nameAr);
      _priceController =
          TextEditingController(text: product.price.toString());
      _oldPriceController =
          TextEditingController(text: product.oldPrice?.toString() ?? '');
      _stockController =
          TextEditingController(text: product.stock.toString());
      _descriptionController =
          TextEditingController(text: product.description ?? '');
      _imageUrlController =
          TextEditingController(text: product.image ?? '');
      _isFeatured = product.isFeatured;
      _isBestSeller = product.isBestSeller;
      _isNew = product.isNew;
      if (product.categoryName != null) {
        _selectedCategory = product.categoryName;
      }
    } else {
      _nameController = TextEditingController();
      _nameArController = TextEditingController();
      _priceController = TextEditingController();
      _oldPriceController = TextEditingController();
      _stockController = TextEditingController(text: '10');
      _descriptionController = TextEditingController();
      _imageUrlController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameArController.dispose();
    _priceController.dispose();
    _oldPriceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _isEditing ? 'تعديل منتج' : 'إضافة منتج',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildImagePicker(),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _nameController,
                label: 'اسم المنتج (عربي)',
                prefixIcon: Icons.inventory_2_outlined,
                validator: (value) =>
                    value!.isEmpty ? 'اسم المنتج مطلوب' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _nameArController,
                label: 'Product Name (English)',
                prefixIcon: Icons.language,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _priceController,
                      label: 'السعر',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.payments_outlined,
                      validator: (value) {
                        if (value!.isEmpty) return 'السعر مطلوب';
                        if (double.tryParse(value) == null) {
                          return 'قيمة غير صحيحة';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      controller: _oldPriceController,
                      label: 'السعر قبل الخصم',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.percent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _stockController,
                label: 'الكمية المتوفرة',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.numbers,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'التصنيف',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'electronics',
                    child: Text('إلكترونيات'),
                  ),
                  DropdownMenuItem(
                    value: 'fashion',
                    child: Text('أزياء'),
                  ),
                  DropdownMenuItem(
                    value: 'home',
                    child: Text('منزل'),
                  ),
                  DropdownMenuItem(
                    value: 'beauty',
                    child: Text('جمال'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _imageUrlController,
                label: 'رابط الصورة الرئيسية',
                keyboardType: TextInputType.url,
                prefixIcon: Icons.link,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _descriptionController,
                label: 'وصف المنتج',
                maxLines: 4,
                prefixIcon: Icons.notes_outlined,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('منتج مميز'),
                      value: _isFeatured,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          _isFeatured = value;
                        });
                      },
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('الأكثر مبيعاً'),
                      value: _isBestSeller,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          _isBestSeller = value;
                        });
                      },
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('جديد'),
                      value: _isNew,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          _isNew = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: _isEditing ? 'تحديث المنتج' : 'إضافة المنتج',
                icon: _isEditing ? Icons.update : Icons.add,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.snackbar(
                      'تم بنجاح',
                      _isEditing
                          ? 'تم تحديث المنتج'
                          : 'تم إضافة المنتج',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.success,
                      colorText: Colors.white,
                    );
                    Get.back();
                  }
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          'إضافة صورة',
          'اختر صورة من المعرض',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 50,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              'اضغط لإضافة صورة المنتج',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'PNG, JPG - بحد أقصى 5MB',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}