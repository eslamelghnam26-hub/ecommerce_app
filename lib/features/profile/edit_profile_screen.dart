import 'package:ecommerce_app/app/theme/app_theme.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;
    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = user?.phone ?? '';
    addressController.text = user?.address ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'تعديل الملف الشخصي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                label: 'الاسم الكامل',
                prefixIcon: Icons.person_outline,
                validator: (value) =>
                    value!.isEmpty ? 'الاسم مطلوب' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: emailController,
                label: 'البريد الإلكتروني',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                validator: (value) {
                  if (value!.isEmpty) return 'البريد الإلكتروني مطلوب';
                  if (!GetUtils.isEmail(value)) return 'بريد غير صحيح';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: phoneController,
                label: 'رقم الهاتف',
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: addressController,
                label: 'العنوان',
                maxLines: 2,
                prefixIcon: Icons.home_outlined,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'حفظ التغييرات',
                icon: Icons.save_outlined,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.snackbar(
                      'تم بنجاح',
                      'تم تحديث الملف الشخصي',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.success,
                      colorText: Colors.white,
                    );
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}