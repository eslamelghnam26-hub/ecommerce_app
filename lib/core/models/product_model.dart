class Product {
  final int? id;
  final String name;
  final String nameAr;
  final String? description;
  final String? descriptionAr;
  final double price;
  double? oldPrice;
  final String? image;
  final List<String> images;
  final int categoryId;
  String? categoryName;
  final int stock;
  final double rating;
  final int ratingCount;
  final bool isFeatured;
  final bool isBestSeller;
  final bool isNew;
  final bool isOnSale;

  Product({
    this.id,
    required this.name,
    required this.nameAr,
    this.description,
    this.descriptionAr,
    required this.price,
    this.oldPrice,
    this.image,
    this.images = const [],
    required this.categoryId,
    this.categoryName,
    this.stock = 0,
    this.rating = 0,
    this.ratingCount = 0,
    this.isFeatured = false,
    this.isBestSeller = false,
    this.isNew = false,
    this.isOnSale = false,
  });

  bool get inStock => stock > 0;
  double get discountPercentage {
    if (oldPrice == null || oldPrice! <= price) return 0;
    return ((oldPrice! - price) / oldPrice! * 100).roundToDouble();
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    List<String> parseImages(dynamic data) {
      if (data == null) return [];
      if (data is List) {
        return data.map((e) => e.toString()).toList();
      }
      return [data.toString()];
    }

    return Product(
      id: json['id'] ?? json['_id'],
      name: json['name'] ?? '',
      nameAr: json['name_ar'] ?? json['name'] ?? '',
      description: json['description'],
      descriptionAr: json['description_ar'] ?? json['description'],
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: json['old_price'] != null
          ? (json['old_price']).toDouble()
          : json['original_price'] != null
              ? (json['original_price']).toDouble()
              : null,
      image: json['image'] ?? (json['images'] != null && json['images'].isNotEmpty ? json['images'][0] : null),
      images: parseImages(json['images']),
      categoryId: json['category_id'] ?? json['category'] ?? 0,
      categoryName: json['category_name'],
      stock: json['stock'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      ratingCount: json['rating_count'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
      isBestSeller: json['is_best_seller'] ?? false,
      isNew: json['is_new'] ?? false,
      isOnSale: json['is_on_sale'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'description': description,
      'description_ar': descriptionAr,
      'price': price,
      'old_price': oldPrice,
      'image': image,
      'images': images,
      'category_id': categoryId,
      'category_name': categoryName,
      'stock': stock,
      'rating': rating,
      'rating_count': ratingCount,
      'is_featured': isFeatured,
      'is_best_seller': isBestSeller,
      'is_new': isNew,
      'is_on_sale': isOnSale,
    };
  }
}
