import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';
import '../product/product_detail_sheet.dart';
import '../search/search_results_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedDepartmentIndex = 0;

  final List<Map<String, dynamic>> _departments = [
    {
      'name': 'Electronics',
      'icon': Icons.headphones_rounded,
      'types': ['Mobiles', 'Audio', 'Power banks', 'Smart watches', 'Appliances'],
      'brands': ['Hanover', 'Pulse', 'Sony', 'Apple'],
      'banner': 'UP TO 40% OFF · Electronics · 2,480 products',
      'products': [
        const ProductModel(
          id: 'cat_e1',
          title: 'Pro Wireless Earbuds ANC',
          storeName: 'Glow Audio',
          price: 59,
          originalPrice: 79,
          imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400&auto=format&fit=crop',
          rating: 4.7,
          reviewsCount: 312,
        ),
        const ProductModel(
          id: 'cat_e2',
          title: 'MagSafe Power Bank 10,000 mAh',
          storeName: 'Glow Audio',
          price: 39,
          originalPrice: 49,
          imageUrl: 'https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=400&auto=format&fit=crop',
          rating: 4.5,
          reviewsCount: 96,
        ),
      ],
    },
    {
      'name': 'Fashion',
      'icon': Icons.checkroom_rounded,
      'types': ['Men', 'Women', 'Footwear', 'Accessories', 'Ethnic'],
      'brands': ['Zara', 'Stride', 'H&M'],
      'banner': 'SUMMER COLLECTION · Up to 50% off fashion',
      'products': [
        const ProductModel(
          id: 'cat_f1',
          title: 'Women Beautiful White Sneakers',
          storeName: 'Cool Sneakers',
          price: 70,
          originalPrice: 90,
          imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&auto=format&fit=crop',
          rating: 4.6,
          reviewsCount: 140,
        ),
      ],
    },
    {
      'name': 'Jewellery',
      'icon': Icons.diamond_rounded,
      'types': ['Necklaces', 'Rings', 'Earrings', 'Bracelets', 'Gold'],
      'brands': ['Aurel', 'Tanishq', 'Giva'],
      'banner': 'HALLMARKED GOLD & SILVER · Certified jewellery',
      'products': [
        const ProductModel(
          id: 'cat_j1',
          title: '18K White Gold Diamond Necklace',
          storeName: 'Rozio Store',
          price: 1680,
          originalPrice: 2400,
          imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400&auto=format&fit=crop',
          rating: 4.9,
          reviewsCount: 58,
        ),
      ],
    },
    {'name': 'Watches', 'icon': Icons.watch_rounded, 'types': ['Smart Watches', 'Luxury', 'Sports', 'Analog'], 'brands': ['Kestrel', 'Apple', 'Fossil'], 'banner': 'SMART & LUXURY WATCHES', 'products': []},
    {'name': 'Footwear', 'icon': Icons.skateboarding_rounded, 'types': ['Sneakers', 'Running', 'Loafers', 'Boots'], 'brands': ['Nike', 'Puma', 'Stride'], 'banner': 'TRENDING FOOTWEAR', 'products': []},
    {'name': 'Home', 'icon': Icons.home_rounded, 'types': ['Decor', 'Lighting', 'Kitchen', 'Bedding'], 'brands': ['Nordhaus', 'Ikea'], 'banner': 'HOME MAKEOVER SALE', 'products': []},
    {'name': 'Furniture', 'icon': Icons.chair_rounded, 'types': ['Sofas', 'Desks', 'Chairs', 'Tables'], 'brands': ['Urban Ladder', 'Nordhaus'], 'banner': 'MODERN FURNITURE', 'products': []},
    {'name': 'Books', 'icon': Icons.menu_book_rounded, 'types': ['Fiction', 'Business', 'Self-Help', 'Children'], 'brands': ['Penguin', 'Harper'], 'banner': 'BESTSELLERS OF 2026', 'products': []},
  ];

  @override
  Widget build(BuildContext context) {
    final dept = _departments[_selectedDepartmentIndex];
    final types = dept['types'] as List<String>;
    final brands = dept['brands'] as List<String>;
    final products = dept['products'] as List<ProductModel>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '${_departments.length} departments',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // Left Rail: Departments
          Container(
            width: 100,
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border(right: BorderSide(color: AppColors.border)),
            ),
            child: ListView.builder(
              itemCount: _departments.length,
              itemBuilder: (context, index) {
                final d = _departments[index];
                final isSelected = _selectedDepartmentIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDepartmentIndex = index),
                  child: Container(
                    color: isSelected ? Colors.white : Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.12)
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            d['icon'] as IconData,
                            size: 20,
                            color: isSelected ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          d['name'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Right Content: Types, Brands, Banner, Products
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promotional Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, Color(0xFF1E40AF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dept['banner'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SearchResultsScreen(query: dept['name'] as String),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Shop all',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Shop by Type
                  const Text(
                    'Shop by type',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: types.map((type) => ActionChip(
                      label: Text(type),
                      backgroundColor: AppColors.surfaceLight,
                      side: const BorderSide(color: AppColors.border),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchResultsScreen(query: type),
                          ),
                        );
                      },
                    )).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Top Brands
                  const Text(
                    'Top brands',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: brands.map((brand) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        brand,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Popular in Department
                  Text(
                    'Popular in ${dept['name']}',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 12),
                  ...products.map((p) => GestureDetector(
                    onTap: () => ProductDetailSheet.show(context, p),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              p.imageUrl,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      '\$${p.price.toInt()}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    if (p.originalPrice > p.price)
                                      Text(
                                        '\$${p.originalPrice.toInt()}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          decoration: TextDecoration.lineThrough,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
