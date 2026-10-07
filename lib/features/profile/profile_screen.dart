import 'package:ecommerce_app/app/theme/app_theme.dart';
import 'package:ecommerce_app/features/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'حسابي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User info card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          authController.currentUser.value?.name ?? 'مستخدم',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          authController.currentUser.value?.email ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Menu items
          _MenuSection(
            items: [
              _MenuItem(
                icon: Icons.person_outline,
                title: 'تعديل الملف الشخصي',
                trailing: Icons.chevron_left,
                onTap: () => Get.toNamed('/edit-profile'),
              ),
              _MenuItem(
                icon: Icons.receipt_long_outlined,
                title: 'طلباتي',
                trailing: Icons.chevron_left,
                onTap: () => Get.toNamed('/orders'),
              ),
              _MenuItem(
                icon: Icons.favorite_outline,
                title: 'مفضلتي',
                trailing: Icons.chevron_left,
                onTap: () => Get.toNamed('/favorites'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (authController.isAdmin) ...[
            _MenuSection(
              items: [
                _MenuItem(
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'لوحة تحكم المشرف',
                  trailing: Icons.chevron_left,
                  onTap: () => Get.toNamed('/admin'),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
          _MenuSection(
            items: [
              _MenuItem(
                icon: Icons.settings_outlined,
                title: 'الإعدادات',
                trailing: Icons.chevron_left,
                onTap: () {
                  Get.bottomSheet(const _SettingsSheet());
                },
              ),
              _MenuItem(
                icon: Icons.notifications_outlined,
                title: 'الإشعارات',
                trailing: Icons.chevron_left,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Language
          _MenuSection(
            items: [
              _MenuItem(
                icon: Icons.language,
                title: 'اللغة',
                subtitle: 'العربية',
                trailing: Icons.chevron_left,
                onTap: () {
                  Get.bottomSheet(const _LanguageSheet());
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: logout,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              minimumSize: const Size(double.infinity, 50),
              side: const BorderSide(color: AppColors.error),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.find<AuthController>().logout();
            },
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final List<Widget> items;

  const _MenuSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      item,
                      if (item != items.last)
                        Divider(height: 1, color: Colors.grey.shade200),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final IconData trailing;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(fontSize: 12))
          : null,
      trailing: Icon(trailing, color: Colors.grey.shade400),
      onTap: onTap,
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'اختر اللغة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('العربية'),
            trailing: const Icon(Icons.check, color: AppColors.primary),
            onTap: () {
              Get.updateLocale(const Locale('ar'));
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('English'),
            onTap: () {
              Get.updateLocale(const Locale('en'));
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsSheet extends StatelessWidget {
  const _SettingsSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'الإعدادات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.brightness_6_outlined),
            title: Text('الوضع الليلي'),
            trailing: Switch(value: false, onChanged: null),
          ),
          const ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text('تفعيل الإشعارات'),
            trailing: Switch(value: true, onChanged: null),
          ),
        ],
      ),
    );
  }
}