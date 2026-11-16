import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/location_provider.dart';
import '../product/product_detail_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<ProductModel> _sampleProducts = [
    ProductModel(
      id: 'prod_1',
      title: 'Pro Wireless Earbuds ANC',
      storeName: 'Glow Audio',
      price: 59,
      originalPrice: 79,
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'prod_2',
      title: 'Nova AMOLED Smartwatch',
      storeName: 'Urban Tech Co',
      price: 89,
      originalPrice: 129,
      imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'prod_3',
      title: 'Minimalist Leather Backpack',
      storeName: 'Nordic Goods',
      price: 65,
      originalPrice: 95,
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'prod_4',
      title: 'Mechanical RGB Keyboard',
      storeName: 'Apex Gaming',
      price: 110,
      originalPrice: 150,
      imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400&auto=format&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationProvider>();
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Top App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Row(
                  children: [
                    // Brand & Location
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rozio',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(
                                '${location.city} ${location.pincode}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.textSecondary),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Notification Icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 22),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: AppColors.textSecondary, size: 22),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Search products, brands and reels...',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic_none_rounded, color: AppColors.textSecondary, size: 20),
                        onPressed: () {},
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Stories / Live Reels Bar
            SliverToBoxAdapter(
              child: SizedBox(
                height: 104,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildStoryItem('Glow Audio', 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=200', true),
                    _buildStoryItem('Urban Tech', 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=200', true),
                    _buildStoryItem('Nordic Style', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=200', false),
                    _buildStoryItem('Apex Gaming', 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=200', false),
                    _buildStoryItem('Nova Beauty', 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=200', false),
                  ],
                ),
              ),
            ),

            // Banner Carousel
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'SPECIAL REEL DEAL',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Get 10% Extra Off',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Use coupon REEL10 on orders over \$50',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'Claim',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Section Header
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending in Reels',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Products Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = _sampleProducts[index % _sampleProducts.length];
                    return GestureDetector(
                      onTap: () => ProductDetailSheet.show(context, product),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Thumbnail
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                                    child: Image.network(
                                      product.imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                                      child: const Icon(Icons.favorite_border, size: 16, color: AppColors.textPrimary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Details
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.storeName,
                                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${product.price.toStringAsFixed(0)}',
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cart.addItem(
                                            product: product,
                                            selectedColor: product.availableColors.first,
                                            selectedEdition: product.availableEditions.first,
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Added ${product.title} to bag!'),
                                              duration: const Duration(seconds: 1),
                                              backgroundColor: AppColors.primary,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: const BoxDecoration(
                                            color: AppColors.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.add, size: 16, color: Colors.white),
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
                    );
                  },
                  childCount: _sampleProducts.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryItem(String name, String imageUrl, bool isLive) {
    return Container(
      width: 76,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isLive
                      ? const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFF97316)])
                      : const LinearGradient(colors: [AppColors.primary, Color(0xFF60A5FA)]),
                ),
                padding: const EdgeInsets.all(2.5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              if (isLive)
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
