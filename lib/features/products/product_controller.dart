import 'package:ecommerce_app/core/data/mock_data.dart';
import 'package:ecommerce_app/core/models/category_model.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/core/api/api_client.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ApiClient _apiClient = Get.find<ApiClient>();

  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> featuredProducts = <Product>[].obs;
  final RxList<Product> bestSellerProducts = <Product>[].obs;
  final RxList<Product> newProducts = <Product>[].obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isCategoriesLoading = false.obs;
  final RxString error = ''.obs;
  final RxInt selectedCategory = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxString sortBy = 'latest'.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMore = true.obs;

  bool _isMockMode = false;
  bool get isMockMode => _isMockMode;

  List<Product> get filteredProducts {
    var result = _isMockMode ? _mockFiltered() : products.toList();

    if (selectedCategory.value != 0) {
      result = result
          .where((p) => p.categoryId == selectedCategory.value)
          .toList();
    }

    if (searchQuery.value.isNotEmpty) {
      result = result
          .where((p) =>
              p.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              p.nameAr.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    return result;
  }

  List<Product> _mockFiltered() {
    var result = MockData.productsByCategory(selectedCategory.value);
    result = MockData.searchProducts(searchQuery.value);
    result = MockData.sortProducts(result, sortBy.value);
    return result;
  }

  @override
  void onInit() {
    super.onInit();
    _loadHomeSections();
    fetchCategories();
    fetchProducts();
  }

  Future<void> _loadHomeSections() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (products.isEmpty) {
      _setMockHomeData();
    }
  }

  void _setMockHomeData() {
    if (bestSellerProducts.isEmpty) {
      final sorted = [...MockData.products]
        ..sort((a, b) => b.ratingCount.compareTo(a.ratingCount));
      bestSellerProducts.value = sorted.take(8).toList();
    }
    if (newProducts.isEmpty) {
      newProducts.value =
          MockData.products.where((p) => p.isNew).take(6).toList();
    }
    if (featuredProducts.isEmpty) {
      featuredProducts.value =
          MockData.products.where((p) => p.isFeatured).take(6).toList();
    }
  }

  Future<void> fetchProducts({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      hasMore.value = true;
      products.clear();
    }

    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    error.value = '';

    try {
      final response = await _apiClient.get(
        '/products',
        queryParameters: {
          'page': currentPage.value,
          'search': searchQuery.value.isEmpty ? null : searchQuery.value,
          'category_id': selectedCategory.value == 0 ? null : selectedCategory.value,
          'sort': sortBy.value,
        },
      );

      final data = response.data;
      final List<dynamic> items = data['data'] ?? data['products'] ?? [];

      for (var item in items) {
        products.add(Product.fromJson(item as Map<String, dynamic>));
      }

      final total = data['total'] ?? items.length;
      hasMore.value = products.length < total;
      currentPage.value++;

      if (items.isEmpty) {
        _isMockMode = true;
        _setMockHomeData();
      }
    } catch (e) {
      _isMockMode = true;
      _loadMockIntoProducts();
      error.value = '';
    } finally {
      isLoading.value = false;
      if (_isMockMode) {
        hasMore.value = false;
      }
    }
  }

  void _loadMockIntoProducts() {
    if (products.isEmpty) {
      products.value = MockData.products.toList();
    }
    _setMockHomeData();
  }

  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    try {
      final response = await _apiClient.get('/categories');
      final data = response.data;

      final List<dynamic> items = data is List
          ? data
          : (data['data'] ?? data['categories'] ?? []);

      if (items.isEmpty) {
        categories.value = MockData.categories;
      } else {
        categories.value = items
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      categories.value = MockData.categories;
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  void selectCategory(int categoryId) {
    selectedCategory.value = categoryId;
    if (_isMockMode) {
      _applyMockFilter();
    } else {
      fetchProducts(refresh: true);
    }
  }

  void search(String query) {
    searchQuery.value = query;
    if (_isMockMode) {
      _applyMockFilter();
    } else {
      fetchProducts(refresh: true);
    }
  }

  void changeSort(String value) {
    sortBy.value = value;
    if (_isMockMode) {
      _applyMockFilter();
    } else {
      fetchProducts(refresh: true);
    }
  }

  void _applyMockFilter() {
    var result = MockData.productsByCategory(selectedCategory.value);
    final q = searchQuery.value.toLowerCase();
    if (searchQuery.value.isNotEmpty) {
      result = result
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.nameAr.toLowerCase().contains(q))
          .toList();
    }
    products.value = MockData.sortProducts(result, sortBy.value);
  }

  void loadMore() {
    if (_isMockMode) return;
    if (hasMore.value && !isLoading.value) {
      fetchProducts();
    }
  }
}