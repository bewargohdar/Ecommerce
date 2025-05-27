import 'package:ecomerce/features/category/domain/entity/category.dart';

class CategoryImageHelper {
  static const Map<String, String> categoryImages = {
    'beauty':
        'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400',
    'fragrances':
        'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400',
    'furniture':
        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
    'groceries':
        'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400',
    'home-decoration':
        'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400',
    'kitchen-accessories':
        'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
    'laptops':
        'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
    'mens-shirts':
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
    'mens-shoes':
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400',
    'mens-watches':
        'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400',
    'mobile-accessories':
        'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=400',
    'motorcycle':
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
    'skin-care':
        'https://images.unsplash.com/photo-1556228578-626bdc3bf4e4?w=400',
    'smartphones':
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
    'sports-accessories':
        'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
    'sunglasses':
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400',
    'tablets':
        'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
    'tops':
        'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400',
    'vehicle':
        'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=400',
    'womens-bags':
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
    'womens-dresses':
        'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400',
    'womens-jewellery':
        'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=400',
    'womens-shoes':
        'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=400',
    'womens-watches':
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
  };

  static String getImageUrl(String categorySlug) {
    return categoryImages[categorySlug] ??
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400'; // Default image
  }
}

// Extension to add image URL to CategoryEntity
extension CategoryEntityExtension on CategoryEntity {
  String get imageUrl => CategoryImageHelper.getImageUrl(slug);
}
