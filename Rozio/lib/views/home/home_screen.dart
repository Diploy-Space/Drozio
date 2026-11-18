import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/location_provider.dart';
import '../catalog/figma_screen_catalog.dart';
import '../categories/categories_screen.dart';
import '../deals/clearance_sale_screen.dart';
import '../deals/featured_products_screen.dart';
import '../deals/first_order_screen.dart';
import '../deals/flash_deal_screen.dart';
import '../notifications/notifications_screen.dart';
import '../onboarding/pincode_location_screen.dart';
import '../product/product_detail_sheet.dart';
import '../reels/reels_screen.dart';
import '../search/rozio_ai_screen.dart';
import '../search/search_screen.dart';
import '../search/voice_search_sheet.dart';
import '../store/top_stores_screen.dart';
import '../store/store_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedMode = 'Just for you';
  String _selectedProductTab = 'New arrivals';

  int _flashSeconds = 9 * 3600 + 29 * 60 + 36;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _flashSeconds > 0) {
        setState(() => _flashSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _hours => (_flashSeconds ~/ 3600).toString().padLeft(2, '0');
  String get _minutes => ((_flashSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
  String get _seconds => (_flashSeconds % 60).toString().padLeft(2, '0');

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
      title: 'Women White Leather Sneakers',
      storeName: 'Cool Sneakers',
      price: 70,
      originalPrice: 95,
      imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'prod_4',
      title: 'Mechanical RGB Keyboard',
      storeName: 'Apex Gaming',
      price: 110,
      originalPrice: 150,
      imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'prod_5',
      title: '18K White Gold Diamond Necklace',
      storeName: 'Rozio Store',
      price: 1680,
      originalPrice: 2400,
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'prod_6',
      title: 'Samsung Galaxy S24 Ultra 256GB',
      storeName: 'Hanover Electronics',
      price: 1150,
      originalPrice: 1300,
      imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400&auto=format&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationProvider>();
    context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 6,
        icon: const Icon(Icons.auto_awesome_mosaic_rounded, color: Colors.amber, size: 20),
        label: const Text(
          'Figma Screens (95)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FigmaScreenCatalogScreen()),
          );
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Top App Bar: Brand, Location & Figma Navigator Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Row(
                  children: [
                    // Brand & Location Selector
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PincodeLocationScreen()),
                          );
                        },
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
                    ),

                    // Quick Figma Catalog Pill
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FigmaScreenCatalogScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.layers_rounded, size: 14, color: AppColors.primary),
                            SizedBox(width: 4),
                            Text('All 95 Pages', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),

                    // Notification Icon -> Screen 23
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 20),
                            Positioned(
                              top: 8,
                              right: 9,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar & AI CTA (Screen 03, 04, 07)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SearchScreen()),
                          );
                        },
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search_rounded, color: AppColors.textMuted, size: 20),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'Search products, brands and reels...',
                                  style: TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.mic_none_rounded, color: AppColors.primary, size: 20),
                                onPressed: () => VoiceSearchSheet.show(context),
                                visualDensity: VisualDensity.compact,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Ask AI Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RozioAiScreen()),
                        );
                      },
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text('Ask AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Mode Selector Tabs: Just for you, Retail, Wholesale, Auction
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                child: Row(
                  children: ['Just for you', 'Retail', 'Wholesale', 'Auction'].map((mode) {
                    final isSelected = _selectedMode == mode;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(mode, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
                        onSelected: (_) => setState(() => _selectedMode = mode),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Shop Reels Stories Row (Screen 24 entry)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 98,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildStoryAvatar('Glow Audio', 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop', false),
                    _buildStoryAvatar('Rozio Store', 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&auto=format&fit=crop', true),
                    _buildStoryAvatar('Hanover Tech', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop', false),
                    _buildStoryAvatar('Cool Sneakers', 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200&auto=format&fit=crop', false),
                    _buildStoryAvatar('UrbanEdge', 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200&auto=format&fit=crop', false),
                    _buildStoryAvatar('Global Tech', 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200&auto=format&fit=crop', false),
                  ],
                ),
              ),
            ),

            // Hero Promo Carousel Banners
            SliverToBoxAdapter(
              child: SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildPromoBanner(
                      tag: 'NEW IN',
                      title: 'Elevate your audio',
                      subtitle: 'Wireless sound from top audio stores.',
                      cta: 'Shop now',
                      gradient: const [Color(0xFF0F172A), Color(0xFF1E293B)],
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeaturedProductsScreen())),
                    ),
                    const SizedBox(width: 12),
                    _buildPromoBanner(
                      tag: 'JUST LANDED',
                      title: 'Galaxy S24 Ultra',
                      subtitle: 'From \$1,150 at Hanover Electronics.',
                      cta: 'Shop now',
                      gradient: const [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StoreDetailScreen(storeName: 'Hanover Electronics'))),
                    ),
                    const SizedBox(width: 12),
                    _buildPromoBanner(
                      tag: 'FOOTWEAR',
                      title: 'Fresh pairs',
                      subtitle: 'New sneakers from verified stores.',
                      cta: 'Browse',
                      gradient: const [Color(0xFF7C2D12), Color(0xFFEA580C)],
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesScreen())),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),

            // Special Deals Row (Today's Deal, Clearance, First-Order)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Clearance Sale
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClearanceSaleScreen())),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFFECACA)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CLEARANCE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 10)),
                              SizedBox(height: 4),
                              Text('Save up to -20%', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // First Order
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FirstOrderExclusivesScreen())),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7ED),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFFED7AA)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('NEW USER', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w900, fontSize: 10)),
                              SizedBox(height: 4),
                              Text('FIRST5 Coupon', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // FLASH DEAL Section with Countdown
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFFE4E6)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bolt_rounded, color: Colors.red, size: 24),
                        const SizedBox(width: 6),
                        const Text('FLASH DEAL', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.textPrimary)),
                        const Spacer(),
                        // Timer badges
                        _buildTimerBadge(_hours),
                        const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildTimerBadge(_minutes),
                        const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildTimerBadge(_seconds),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Up to 20% off ends soon', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FlashDealScreen())),
                          child: const Text('View all >', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Live Auctions Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Live Auctions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                          child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 170,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildAuctionCard(
                          title: 'Beige Tufted 2-Seater Loveseat',
                          highestBid: '\$500',
                          bidsCount: '6 bids · 34 watching',
                          timeLeft: '2h 14m',
                          imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300&auto=format&fit=crop',
                        ),
                        const SizedBox(width: 14),
                        _buildAuctionCard(
                          title: 'Sterling Silver Solitaire Diamond Ring',
                          highestBid: '\$200',
                          bidsCount: 'No bids yet · 49 watching',
                          timeLeft: '1d 06h',
                          imageUrl: 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=300&auto=format&fit=crop',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Featured Stores Section (Screen 20)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Top Stores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TopStoresScreen())),
                          child: const Text('See all', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 110,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildStoreCard('Rozio Store', '4.75 ★ · 194 items', true),
                        const SizedBox(width: 12),
                        _buildStoreCard('Hanover Tech', 'New · 19 items', false),
                        const SizedBox(width: 12),
                        _buildStoreCard('UrbanEdge', '4.6 ★ · 62 items', false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Product Tabs: New arrivals, Top products, Best selling, Discounted
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: ['New arrivals', 'Top products', 'Best selling', 'Discounted'].map((t) {
                    final isSelected = _selectedProductTab == t;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(t, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
                        onSelected: (_) => setState(() => _selectedProductTab = t),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),

            // Products Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = _sampleProducts[index % _sampleProducts.length];
                    return GestureDetector(
                      onTap: () => ProductDetailSheet.show(context, product),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                    child: Image.network(
                                      product.imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, _, _) => Container(color: AppColors.surfaceLight),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.white.withValues(alpha: 0.85),
                                      child: const Icon(Icons.favorite_border_rounded, size: 16, color: AppColors.textSecondary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.storeName, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 2),
                                  Text(product.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text('\$${product.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: AppColors.primary)),
                                      const SizedBox(width: 4),
                                      if (product.originalPrice > product.price)
                                        Text('\$${product.originalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted, decoration: TextDecoration.lineThrough)),
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
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryAvatar(String storeName, String imageUrl, bool isLive) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReelsScreen())),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: 70,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: isLive ? [Colors.red, Colors.orange] : [AppColors.primary, AppColors.accent],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                if (isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                    child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(storeName, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner({
    required String tag,
    required String title,
    required String subtitle,
    required String cta,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tag, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1.2)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
            const Spacer(),
            Text('$cta >', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerBadge(String val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
      child: Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildAuctionCard({
    required String title,
    required String highestBid,
    required String bidsCount,
    required String timeLeft,
    required String imageUrl,
  }) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(imageUrl, width: 85, height: double.infinity, fit: BoxFit.cover, errorBuilder: (_, _, _) => Container(color: Colors.grey.shade200)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  Text(highestBid, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: AppColors.primary)),
                  Text(bidsCount, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                  const SizedBox(height: 2),
                  Text('Closes in $timeLeft', style: const TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(String name, String sub, bool verified) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              if (verified) ...[
                const SizedBox(width: 4),
                const Icon(Icons.verified_rounded, size: 14, color: AppColors.primary),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(sub, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          const Spacer(),
          SizedBox(
            height: 26,
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeName: name))),
              child: const Text('Follow', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
