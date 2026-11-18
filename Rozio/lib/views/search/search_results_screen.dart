import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';
import '../cart/cart_screen.dart';
import '../product/product_detail_sheet.dart';
import 'filters_bottom_sheet.dart';
import 'rozio_ai_screen.dart';
import 'sort_bottom_sheet.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({
    super.key,
    required this.query,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late String _activeQuery;
  String _currentSort = 'Relevance';
  FilterState _filters = FilterState();

  static const List<ProductModel> _allCatalog = [
    ProductModel(
      id: 'watch_1',
      title: 'Women Smart Watch, Rose Gold Mesh',
      storeName: 'Global Tech',
      price: 495,
      originalPrice: 500,
      imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500&auto=format&fit=crop',
      rating: 4.7,
      reviewsCount: 96,
    ),
    ProductModel(
      id: 'watch_2',
      title: 'Sport Smart Watch, Ocean Band',
      storeName: 'Global Tech',
      price: 89,
      originalPrice: 110,
      imageUrl: 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=500&auto=format&fit=crop',
      rating: 4.6,
      reviewsCount: 75,
    ),
    ProductModel(
      id: 'watch_3',
      title: 'Smart Watch Bluetooth',
      storeName: 'Hanover Electronics',
      price: 150,
      originalPrice: 180,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop',
      rating: 4.4,
      reviewsCount: 75,
    ),
    ProductModel(
      id: 'earbuds_1',
      title: 'Pro Wireless Earbuds ANC',
      storeName: 'Glow Audio',
      price: 59,
      originalPrice: 79,
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500&auto=format&fit=crop',
      rating: 4.7,
      reviewsCount: 312,
    ),
    ProductModel(
      id: 'necklace_1',
      title: '18K White Gold Diamond Necklace',
      storeName: 'Rozio Store',
      price: 1680,
      originalPrice: 2400,
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500&auto=format&fit=crop',
      rating: 4.9,
      reviewsCount: 58,
    ),
  ];

  final List<String> _relatedKeywords = [
    'smartwatch',
    'watches',
    'fitness',
    'electronics',
  ];

  @override
  void initState() {
    super.initState();
    _activeQuery = widget.query;
  }

  List<ProductModel> get _filteredProducts {
    final q = _activeQuery.toLowerCase().trim();
    if (q.contains('strap') || q.contains('guitar') || q.contains('blue')) {
      return []; // Intentionally empty for Screen 14 verification!
    }

    var list = _allCatalog.where((p) {
      final matchesQuery = p.title.toLowerCase().contains(q) ||
          p.storeName.toLowerCase().contains(q) ||
          (q == 'watch' && p.title.toLowerCase().contains('watch'));
      if (!matchesQuery && q.isNotEmpty && q != 'watch') return false;

      // Filter by price
      if (p.price < _filters.priceRange.start || p.price > _filters.priceRange.end) return false;
      // Filter by rating
      if (_filters.minRating > 0 && p.rating < _filters.minRating) return false;
      // Filter by discount
      if (_filters.discountedOnly && p.originalPrice <= p.price) return false;

      return true;
    }).toList();

    // Sort
    if (_currentSort == 'Price: Low to High') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (_currentSort == 'Price: High to Low') {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else if (_currentSort == 'Customer Rating') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return list;
  }

  void _openSort() async {
    final res = await SortBottomSheet.show(context, _currentSort);
    if (res != null) {
      setState(() => _currentSort = res);
    }
  }

  void _openFilters() async {
    final res = await FiltersBottomSheet.show(context, _filters);
    if (res != null) {
      setState(() => _filters = res);
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;
    final isNoResults = products.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _activeQuery,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (_activeQuery.isNotEmpty)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close_rounded, size: 18, color: AppColors.textSecondary),
                ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              children: [
                // Sort Button
                GestureDetector(
                  onTap: _openSort,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.swap_vert_rounded, size: 16, color: AppColors.textPrimary),
                        const SizedBox(width: 4),
                        Text(
                          _currentSort == 'Relevance' ? 'Sort' : _currentSort,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Filters Button
                GestureDetector(
                  onTap: _openFilters,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: _filters.activeFilterCount > 0
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _filters.activeFilterCount > 0 ? AppColors.primary : AppColors.border,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 16,
                          color: _filters.activeFilterCount > 0 ? AppColors.primary : AppColors.textPrimary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _filters.activeFilterCount > 0 ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                        if (_filters.activeFilterCount > 0) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${_filters.activeFilterCount}',
                              style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Quick Pills
                _buildQuickFilterPill('Under \$100', _filters.priceRange.end <= 100, () {
                  setState(() {
                    if (_filters.priceRange.end <= 100) {
                      _filters.priceRange = const RangeValues(20, 300);
                    } else {
                      _filters.priceRange = const RangeValues(20, 100);
                    }
                  });
                }),
                const SizedBox(width: 8),

                _buildQuickFilterPill('4.5 stars and up', _filters.minRating == 4.5, () {
                  setState(() {
                    _filters.minRating = _filters.minRating == 4.5 ? 0.0 : 4.5;
                  });
                }),
                const SizedBox(width: 8),

                _buildQuickFilterPill('Discounted', _filters.discountedOnly, () {
                  setState(() {
                    _filters.discountedOnly = !_filters.discountedOnly;
                  });
                }),
                const SizedBox(width: 8),

                _buildQuickFilterPill('In stock', _filters.inStockOnly, () {
                  setState(() {
                    _filters.inStockOnly = !_filters.inStockOnly;
                  });
                }),
              ],
            ),
          ),

          // Body Content
          Expanded(
            child: isNoResults
                ? _buildNoResultsView(context)
                : _buildResultsList(context, products),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilterPill(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsList(BuildContext context, List<ProductModel> products) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subheader Info
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${products.length} results for “$_activeQuery”',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.local_shipping_outlined, size: 14, color: Color(0xFF10B981)),
                    SizedBox(width: 4),
                    Text(
                      'Most arrive by Thu, Oct 29',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2-Column Product Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.64,
              crossAxisSpacing: 12,
              mainAxisSpacing: 14,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product);
            },
          ),

          // Related searches chips
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'People also search for',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _relatedKeywords.map((kw) => ActionChip(
                    label: Text(kw),
                    labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary),
                    backgroundColor: AppColors.surfaceLight,
                    side: const BorderSide(color: AppColors.border),
                    onPressed: () {
                      setState(() => _activeQuery = kw);
                    },
                  )).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () => ProductDetailSheet.show(context, product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Discount Tag
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (product.originalPrice > product.price)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-${(((product.originalPrice - product.price) / product.originalPrice) * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.storeName,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        ' (${product.reviewsCount})',
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toInt()}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (product.originalPrice > product.price)
                        Text(
                          '\$${product.originalPrice.toInt()}',
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
    );
  }

  // Screen 14: Search No Results View
  Widget _buildNoResultsView(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search_off_rounded, color: Colors.red, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'No results for “$_activeQuery”',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'We looked in 1,240 stores. Try a shorter search, or one of these:',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: _activeQuery.split(' ').map((word) => ActionChip(
                    label: Text(word),
                    labelStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.border),
                    onPressed: () => setState(() => _activeQuery = word),
                  )).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Ask Rozio AI Card (Screen 14)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RozioAiScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ask Rozio AI to find it',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Describe it in your own words and add a budget',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Shop by category
          const Text(
            'Shop by category',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                'Electronics',
                'Fashion',
                'Jewellery',
                'Watches',
                'Footwear',
                'Home',
                'Furniture',
                'Books',
              ].map((cat) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  label: Text(cat),
                  backgroundColor: AppColors.surfaceLight,
                  side: const BorderSide(color: AppColors.border),
                  onPressed: () => setState(() => _activeQuery = cat.toLowerCase()),
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Popular right now recommendations
          const Text(
            'Popular right now',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.64,
              crossAxisSpacing: 12,
              mainAxisSpacing: 14,
            ),
            itemCount: _allCatalog.length.clamp(0, 4),
            itemBuilder: (context, index) {
              final product = _allCatalog[index];
              return _buildProductCard(context, product);
            },
          ),
        ],
      ),
    );
  }
}
