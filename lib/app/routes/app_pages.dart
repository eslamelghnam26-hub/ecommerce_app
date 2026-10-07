import 'package:ecommerce_app/features/splash/splash_screen.dart';
import 'package:ecommerce_app/features/onboarding/onboarding_screen.dart';
import 'package:ecommerce_app/features/auth/login_screen.dart';
import 'package:ecommerce_app/features/auth/register_screen.dart';
import 'package:ecommerce_app/features/auth/forgot_password_screen.dart';
import 'package:ecommerce_app/features/home/main_screen.dart';
import 'package:ecommerce_app/features/products/product_details_screen.dart';
import 'package:ecommerce_app/features/products/all_products_screen.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/features/checkout/order_success_screen.dart';
import 'package:ecommerce_app/features/orders/orders_screen.dart';
import 'package:ecommerce_app/features/orders/order_details_screen.dart';
import 'package:ecommerce_app/features/profile/profile_screen.dart';
import 'package:ecommerce_app/features/profile/edit_profile_screen.dart';
import 'package:ecommerce_app/features/favorites/favorites_screen.dart';
import 'package:ecommerce_app/features/admin/admin_dashboard.dart';
import 'package:ecommerce_app/features/admin/manage_products_screen.dart';
import 'package:ecommerce_app/features/admin/manage_orders_screen.dart';
import 'package:ecommerce_app/features/admin/manage_users_screen.dart';
import 'package:ecommerce_app/features/admin/manage_categories_screen.dart';
import 'package:ecommerce_app/features/admin/add_edit_product_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = Routes.splash;

  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => MainScreen(),
    ),
    GetPage(
      name: Routes.productDetails,
      page: () => const ProductDetailsScreen(),
    ),
    GetPage(
      name: Routes.allProducts,
      page: () => const AllProductsScreen(),
    ),
    GetPage(
      name: Routes.cart,
      page: () => CartScreen(),
    ),
    GetPage(
      name: Routes.checkout,
      page: () => CheckoutScreen(),
    ),
    GetPage(
      name: Routes.orderSuccess,
      page: () => const OrderSuccessScreen(),
    ),
    GetPage(
      name: Routes.orders,
      page: () => const OrdersScreen(),
    ),
    GetPage(
      name: Routes.orderDetails,
      page: () => const OrderDetailsScreen(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: Routes.favorites,
      page: () => const FavoritesScreen(),
    ),
    GetPage(
      name: Routes.admin,
      page: () => const AdminDashboard(),
    ),
    GetPage(
      name: Routes.manageProducts,
      page: () => const ManageProductsScreen(),
    ),
    GetPage(
      name: Routes.manageOrders,
      page: () => const ManageOrdersScreen(),
    ),
    GetPage(
      name: Routes.manageUsers,
      page: () => const ManageUsersScreen(),
    ),
    GetPage(
      name: Routes.manageCategories,
      page: () => ManageCategoriesScreen(),
    ),
    GetPage(
      name: Routes.addEditProduct,
      page: () => const AddEditProductScreen(),
    ),
  ];
}

class Routes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const productDetails = '/product-details';
  static const allProducts = '/all-products';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const orderSuccess = '/order-success';
  static const orders = '/orders';
  static const orderDetails = '/order-details';
  static const profile = '/profile';
  static const editProfile = '/edit-profile';
  static const favorites = '/favorites';
  static const admin = '/admin';
  static const manageProducts = '/admin/products';
  static const manageOrders = '/admin/orders';
  static const manageUsers = '/admin/users';
  static const manageCategories = '/admin/categories';
  static const addEditProduct = '/admin/product-form';
}
