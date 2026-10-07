import 'package:ecommerce_app/core/models/category_model.dart';
import 'package:ecommerce_app/core/models/product_model.dart';

class MockData {
  static final List<Category> categories = [
    Category(
      id: 1,
      name: 'إلكترونيات',
      nameAr: 'إلكترونيات',
      image: 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=200',
    ),
    Category(
      id: 2,
      name: 'أزياء',
      nameAr: 'أزياء',
      image: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=200',
    ),
    Category(
      id: 3,
      name: 'منزل',
      nameAr: 'منزل',
      image: 'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=200',
    ),
    Category(
      id: 4,
      name: 'جمال وعناية',
      nameAr: 'جمال وعناية',
      image: 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=200',
    ),
    Category(
      id: 5,
      name: 'رياضة',
      nameAr: 'رياضة',
      image: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=200',
    ),
  ];

  static final List<Product> products = [
    Product(
      id: 1,
      name: 'هاتف ذكي أندرويد 128GB',
      nameAr: 'هاتف ذكي أندرويد 128GB',
      description:
          'هاتف ذكي بشاشة كبيرة وكاميرا احترافية وذاكرة تخزين كبيرة. يدعم الشحن السريع والبطارية تدوم طوال اليوم.',
      descriptionAr:
          'هاتف ذكي بشاشة كبيرة وكاميرا احترافية وذاكرة تخزين كبيرة. يدعم الشحن السريع والبطارية تدوم طوال اليوم.',
      price: 1899,
      oldPrice: 2299,
      image:
          'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=400',
      images: [
        'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=400',
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
      ],
      categoryId: 1,
      categoryName: 'إلكترونيات',
      stock: 15,
      rating: 4.5,
      ratingCount: 128,
      isBestSeller: true,
      isOnSale: true,
    ),
    Product(
      id: 2,
      name: 'سماعة رأس لاسلكية',
      nameAr: 'سماعة رأس لاسلكية',
      description: 'سماعة رأس بلوتوث عالية الجودة مع عزل للضوضاء وبطارية تدوم 30 ساعة.',
      descriptionAr: 'سماعة رأس بلوتوث عالية الجودة مع عزل للضوضاء وبطارية تدوم 30 ساعة.',
      price: 349,
      oldPrice: 450,
      image:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      images: [
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
        'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=400',
      ],
      categoryId: 1,
      categoryName: 'إلكترونيات',
      stock: 30,
      rating: 4.7,
      ratingCount: 89,
      isFeatured: true,
      isOnSale: true,
      isNew: true,
    ),
    Product(
      id: 3,
      name: 'ساعة ذكية رياضية',
      nameAr: 'ساعة ذكية رياضية',
      description: 'ساعة ذكية متعددة الوظائف مع تتبع اللياقة والنوم ومقاومة للماء.',
      descriptionAr: 'ساعة ذكية متعددة الوظائف مع تتبع اللياقة والنوم ومقاومة للماء.',
      price: 599,
      image:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
      images: [
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
      ],
      categoryId: 1,
      categoryName: 'إلكترونيات',
      stock: 20,
      rating: 4.3,
      ratingCount: 45,
      isBestSeller: true,
    ),
    Product(
      id: 4,
      name: 'حذاء رياضي عصري',
      nameAr: 'حذاء رياضي عصري',
      description: 'حذاء رياضي مريح وأنيق مناسب للجري والملابس اليومية.',
      descriptionAr: 'حذاء رياضي مريح وأنيق مناسب للجري والملابس اليومية.',
      price: 299,
      oldPrice: 399,
      image:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
      images: [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400',
      ],
      categoryId: 2,
      categoryName: 'أزياء',
      stock: 40,
      rating: 4.6,
      ratingCount: 210,
      isFeatured: true,
      isOnSale: true,
      isNew: true,
    ),
    Product(
      id: 5,
      name: 'تيشيرت قطن فاخر',
      nameAr: 'تيشيرت قطن فاخر',
      description: 'تيشيرت قطني ناعم ومريح بمقاسات متنوعة وألوان عصرية.',
      descriptionAr: 'تيشيرت قطني ناعم ومريح بمقاسات متنوعة وألوان عصرية.',
      price: 89,
      image:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      images: [
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      ],
      categoryId: 2,
      categoryName: 'أزياء',
      stock: 100,
      rating: 4.4,
      ratingCount: 320,
      isBestSeller: true,
      isNew: true,
    ),
    Product(
      id: 6,
      name: 'حقيبة جلد أنيقة',
      nameAr: 'حقيبة جلد أنيقة',
      description: 'حقيبة جلدية أنيقة وعملية متعددة الجيوب مناسبة للاستخدام اليومي.',
      descriptionAr: 'حقيبة جلدية أنيقة وعملية متعددة الجيوب مناسبة للاستخدام اليومي.',
      price: 450,
      oldPrice: 600,
      image:
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400',
      images: [
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400',
      ],
      categoryId: 2,
      categoryName: 'أزياء',
      stock: 25,
      rating: 4.8,
      ratingCount: 156,
      isOnSale: true,
    ),
    Product(
      id: 7,
      name: 'مصباح مكتبي LED',
      nameAr: 'مصباح مكتبي LED',
      description: 'مصباح مكتبي بتصميم عصري إضاءة LED متعددة الألوان قابلة للتعديل.',
      descriptionAr: 'مصباح مكتبي بتصميم عصري إضاءة LED متعددة الألوان قابلة للتعديل.',
      price: 129,
      image:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400',
      images: [
        'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400',
      ],
      categoryId: 3,
      categoryName: 'منزل',
      stock: 50,
      rating: 4.2,
      ratingCount: 76,
      isNew: true,
    ),
    Product(
      id: 8,
      name: 'طقم أواني مطبخ',
      nameAr: 'طقم أواني مطبخ',
      description: 'طقم أواني مطبخ عالية الجودة مقاومة للحرارة ومناسبة لجميع أنواع المواقد.',
      descriptionAr: 'طقم أواني مطبخ عالية الجودة مقاومة للحرارة ومناسبة لجميع أنواع المواقد.',
      price: 799,
      oldPrice: 999,
      image:
          'https://images.unsplash.com/photo-1556911220-bff31c812dba?w=400',
      images: [
        'https://images.unsplash.com/photo-1556911220-bff31c812dba?w=400',
      ],
      categoryId: 3,
      categoryName: 'منزل',
      stock: 12,
      rating: 4.6,
      ratingCount: 98,
      isFeatured: true,
      isOnSale: true,
    ),
    Product(
      id: 9,
      name: 'كريم ترطيب البشرة',
      nameAr: 'كريم ترطيب البشرة',
      description: 'كريم ترطيب طبيعي للبشرة بمكونات آمنة ومغذية تدوم طويلاً.',
      descriptionAr: 'كريم ترطيب طبيعي للبشرة بمكونات آمنة ومغذية تدوم طويلاً.',
      price: 149,
      image:
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      images: [
        'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      ],
      categoryId: 4,
      categoryName: 'جمال وعناية',
      stock: 60,
      rating: 4.5,
      ratingCount: 142,
      isBestSeller: true,
    ),
    Product(
      id: 10,
      name: 'عطر شرقي فاخر',
      nameAr: 'عطر شرقي فاخر',
      description: 'عطر شرقي فاخر بمكونات طبيعية تدوم طويلاً وتناسب جميع المناسبات.',
      descriptionAr: 'عطر شرقي فاخر بمكونات طبيعية تدوم طويلاً وتناسب جميع المناسبات.',
      price: 389,
      image:
          'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400',
      images: [
        'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400',
      ],
      categoryId: 4,
      categoryName: 'جمال وعناية',
      stock: 35,
      rating: 4.9,
      ratingCount: 200,
      isFeatured: true,
    ),
    Product(
      id: 11,
      name: 'دمبل قابل للتعديل',
      nameAr: 'دمبل قابل للتعديل',
      description: 'دمبل قابل للتعديل متعدد الأوزان مناسب للتمارين الرياضية في المنزل.',
      descriptionAr: 'دمبل قابل للتعديل متعدد الأوزان مناسب للتمارين الرياضية في المنزل.',
      price: 499,
      image:
          'https://images.unsplash.com/photo-1638536532686-d610adfc8e5c?w=400',
      images: [
        'https://images.unsplash.com/photo-1638536532686-d610adfc8e5c?w=400',
      ],
      categoryId: 5,
      categoryName: 'رياضة',
      stock: 18,
      rating: 4.4,
      ratingCount: 67,
      isNew: true,
    ),
    Product(
      id: 12,
      name: 'زانة يوغا مطاطية',
      nameAr: 'زانة يوغا مطاطية',
      description: 'زانة يوغا مطاطية متينة وغير قابلة للانزلاق مناسبة لجميع التمارين.',
      descriptionAr: 'زانة يوغا مطاطية متينة وغير قابلة للانزلاق مناسبة لجميع التمارين.',
      price: 99,
      oldPrice: 149,
      image:
          'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=400',
      images: [
        'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=400',
      ],
      categoryId: 5,
      categoryName: 'رياضة',
      stock: 45,
      rating: 4.3,
      ratingCount: 51,
      isOnSale: true,
    ),
  ];

  static List<Product> productsByCategory(int categoryId) {
    if (categoryId == 0) return products;
    return products.where((p) => p.categoryId == categoryId).toList();
  }

  static List<Product> searchProducts(String query) {
    if (query.isEmpty) return products;
    final q = query.toLowerCase();
    return products
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.nameAr.toLowerCase().contains(q))
        .toList();
  }

  static List<Product> sortProducts(List<Product> list, String sortBy) {
    final sorted = [...list];
    switch (sortBy) {
      case 'price_low_high':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high_low':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'best_seller':
        sorted.sort((a, b) => b.ratingCount.compareTo(a.ratingCount));
        break;
      default:
        break;
    }
    return sorted;
  }
}