import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/app/theme/app_theme.dart';
import 'package:ecommerce_app/core/widgets/product_card.dart';
import 'package:ecommerce_app/features/favorites/favorites_controller.dart';
import 'package:ecommerce_app/features/products/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool _isGridView = true;
  String _selectedSort = 'latest';

  @override
  void initState() {
    super.initState();
    final title = Get.arguments;
    if (title != null && title is Map && title['title'] != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final controller = Get.find<ProductController>();
        controller.fetchProducts(refresh: true);
      });
    }
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent - 200) {
      Get.find<ProductController>().loadMore();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final favoritesController = Get.find<FavoritesController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'جميع المنتجات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                Get.find<ProductController>().search(value);
              },
            ),
          ),
          // Sort options
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _SortChip(
                  label: 'الأحدث',
                  isSelected: _selectedSort == 'latest',
                  onTap: () {
                    setState(() => _selectedSort = 'latest');
                    productController.changeSort('latest');
                  },
                ),
                _SortChip(
                  label: 'الأكثر مبيعاً',
                  isSelected: _selectedSort == 'best_seller',
                  onTap: () {
                    setState(() => _selectedSort = 'best_seller');
                    productController.changeSort('best_seller');
                  },
                ),
                _SortChip(
                  label: 'السعر: من الأقل للأعلى',
                  isSelected: _selectedSort == 'price_low_high',
                  onTap: () {
                    setState(() => _selectedSort = 'price_low_high');
                    productController.changeSort('price_low_high');
                  },
                ),
                _SortChip(
                  label: 'السعر: من الأعلى للأقل',
                  isSelected: _selectedSort == 'price_high_low',
                  onTap: () {
                    setState(() => _selectedSort = 'price_high_low');
                    productController.changeSort('price_high_low');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Products list
          Expanded(
            child: Obx(
              () {
                if (productController.isLoading.value &&
                    productController.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (productController.products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'لا توجد منتجات مطابقة',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  );
                }

                final products = productController.products;

                return RefreshIndicator(
                  onRefresh: () => productController.fetchProducts(refresh: true),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent * 0.8) {
                        productController.loadMore();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: products.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= products.length) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: productController.hasMore.value
                                  ? const CircularProgressIndicator()
                                  : const SizedBox.shrink(),
                            ),
                          );
                        }
                        final product = products[index];
                        if (_isGridView) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ProductCard(
                              name: product.name,
                              price:
                                  '${product.price.toStringAsFixed(0)} ر.س',
                              oldPrice: product.oldPrice?.toStringAsFixed(0),
                              imageUrl: product.image,
                              showDiscount:
                                  product.discountPercentage > 0,
                              isFavorite:
                                  favoritesController.isFavorite(product),
                              onFavoriteTap: () {
                                favoritesController.toggleFavorite(product);
                              },
                              onTap: () {
                                Get.toNamed('/product-details',
                                    arguments: product);
                              },
                            ),
                          );
                        }
                        return _ListProductTile(
                          product: product,
                          isFavorite: favoritesController.isFavorite(product),
                          onFavoriteTap: () {
                            favoritesController.toggleFavorite(product);
                          },
                          onTap: () {
                            Get.toNamed('/product-details',
                                arguments: product);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _ListProductTile extends StatelessWidget {
  final dynamic product;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  const _ListProductTile({
    required this.product,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: product.image != null
                  ? CachedNetworkImageWidget(url: product.image)
                  : Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.grey.shade400,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(0)} ر.س',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (product.discountPercentage > 0)
                        Text(
                          '${product.oldPrice.toStringAsFixed(0)} ر.س',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  if (product.stock <= 0)
                    Text(
                      'غير متوفر',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: onFavoriteTap,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
  final String url;
  const CachedNetworkImageWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade400,
      ),
    );
  }
}