import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/app/theme/app_theme.dart';
import 'package:ecommerce_app/core/widgets/product_card.dart';
import 'package:ecommerce_app/features/products/product_controller.dart';
import 'package:ecommerce_app/features/favorites/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'متجري',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.toNamed('/cart');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/all-products');
              },
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'ابحث عن منتج...',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => productController.fetchProducts(refresh: true),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildCategoriesSection(productController),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الأكثر مبيعاً',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Get.toNamed('/all-products', arguments: {'title': 'الأكثر مبيعاً'}),
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            Obx(() {
              final products = productController.bestSellerProducts.isNotEmpty
                  ? productController.bestSellerProducts
                  : productController.products;
              if (products.isEmpty && productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (products.isEmpty) {
                return const _EmptyProducts();
              }
              return SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length.clamp(0, 10),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                        width: 160,
                        child: ProductCard(
                          name: product.name,
                          price: '${product.price.toStringAsFixed(0)} ر.س',
                          oldPrice: product.oldPrice?.toStringAsFixed(0),
                          imageUrl: product.image,
                          showDiscount: product.discountPercentage > 0,
                          isFavorite: Get.find<FavoritesController>().isFavorite(product),
                          onFavoriteTap: () {
                            Get.find<FavoritesController>().toggleFavorite(product);
                          },
                          onTap: () {
                            Get.toNamed('/product-details', arguments: product);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'وصل حديثاً',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Get.toNamed('/all-products', arguments: {'title': 'وصل حديثاً'}),
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            Obx(() {
              final products = productController.newProducts.isNotEmpty
                  ? productController.newProducts
                  : productController.products;
              if (products.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.68,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: products.length.clamp(0, 6),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      name: product.name,
                      price: '${product.price.toStringAsFixed(0)} ر.س',
                      oldPrice: product.oldPrice?.toStringAsFixed(0),
                      imageUrl: product.image,
                      showDiscount: product.discountPercentage > 0,
                      isFavorite: Get.find<FavoritesController>().isFavorite(product),
                      onFavoriteTap: () {
                        Get.find<FavoritesController>().toggleFavorite(product);
                      },
                      onTap: () {
                        Get.toNamed('/product-details', arguments: product);
                      },
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(ProductController productController) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التصنيفات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 12),
          if (productController.isCategoriesLoading.value)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            )
          else
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productController.categories.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _CategoryItem(
                      name: 'الكل',
                      icon: Icons.grid_view_rounded,
                      isSelected: productController.selectedCategory.value == 0,
                      onTap: () => productController.selectCategory(0),
                    );
                  }
                  final category = productController.categories[index - 1];
                  return _CategoryItem(
                    name: category.name,
                    imageUrl: category.image,
                    isSelected:
                        productController.selectedCategory.value == category.id,
                    onTap: () =>
                        productController.selectCategory(category.id ?? 0),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.name,
    this.imageUrl,
    this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.white,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(
                        Icons.category_outlined,
                        color: isSelected ? Colors.white : Colors.grey.shade400,
                      ),
                    )
                  : Icon(
                      icon ?? Icons.category_outlined,
                      color: isSelected ? Colors.white : Colors.grey.shade400,
                      size: 28,
                    ),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyProducts extends StatelessWidget {
  const _EmptyProducts();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 50, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              'لا توجد منتجات',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}