import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';
import '../product/product_detail_sheet.dart';
import 'photo_search_screen.dart';
import 'rozio_ai_screen.dart';
import 'search_results_screen.dart';
import 'voice_search_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<String> _recentSearches = [
    'earbuds',
    'sneakers size 38',
    's24 ultra',
  ];

  static const List<ProductModel> _recentlyViewed = [
    ProductModel(
      id: 'recent_1',
      title: '18K White Gold Diamond Necklace',
      storeName: 'Rozio Store',
      price: 1680,
      originalPrice: 2400,
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'recent_2',
      title: 'Pro Wireless Earbuds ANC',
      storeName: 'Glow Audio',
      price: 59,
      originalPrice: 79,
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'recent_3',
      title: 'Women Beautiful White Sneakers',
      storeName: 'Cool Sneakers',
      price: 70,
      originalPrice: 90,
      imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'recent_4',
      title: 'Geometric Ceramic Planters, Set of 3',
      storeName: 'Urban Greens',
      price: 24,
      originalPrice: 35,
      imageUrl: 'https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=400&auto=format&fit=crop',
    ),
  ];

  static const List<Map<String, String>> _trendingToday = [
    {'rank': '1', 'title': 'Wireless earbuds', 'change': '+64%'},
    {'rank': '2', 'title': 'Smart watch', 'change': '+41%'},
    {'rank': '3', 'title': 'White sneakers', 'change': '+33%'},
    {'rank': '4', 'title': 'Gold necklace', 'change': '+18%'},
    {'rank': '5', 'title': 'Ceramic planters', 'change': '+12%'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitSearch(String term) {
    if (term.trim().isEmpty) return;
    if (!_recentSearches.contains(term)) {
      setState(() => _recentSearches.insert(0, term));
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(query: term),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTyping = _query.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Container(
          height: 44,
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    hintText: 'Search Rozio',
                    hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (val) => setState(() => _query = val),
                  onSubmitted: _submitSearch,
                ),
              ),
              if (_query.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear_rounded, size: 18, color: AppColors.textSecondary),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                ),
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined, color: AppColors.textSecondary, size: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PhotoSearchScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.mic_none_rounded, color: AppColors.textSecondary, size: 20),
                onPressed: () => VoiceSearchSheet.show(context),
              ),
            ],
          ),
        ),
      ),
      body: isTyping ? _buildSuggestionsView() : _buildDefaultSearchView(),
    );
  }

  // Screen 03 Default Search View
  Widget _buildDefaultSearchView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shortcuts Row: Photo Search & Rozio AI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Search by Photo Card
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PhotoSearchScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt_rounded, color: AppColors.primary, size: 20),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Search by photo',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Find what you see',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Ask Rozio AI Card
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RozioAiScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.08),
                            const Color(0xFF8B5CF6).withValues(alpha: 0.08),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, Color(0xFF8B5CF6)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Ask Rozio AI',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Describe it, add a budget',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent searches',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _recentSearches.clear()),
                    child: const Text('Clear', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _recentSearches.map((term) => ActionChip(
                  avatar: const Icon(Icons.history_rounded, size: 16, color: AppColors.textSecondary),
                  label: Text(term),
                  backgroundColor: AppColors.surfaceLight,
                  side: BorderSide(color: AppColors.border),
                  onPressed: () => _submitSearch(term),
                )).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Recently Viewed Horizontal Scroll
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recently viewed',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Clear', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _recentlyViewed.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = _recentlyViewed[index];
                return GestureDetector(
                  onTap: () => ProductDetailSheet.show(context, product),
                  child: SizedBox(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            product.imageUrl,
                            width: 130,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '\$${product.price.toInt()}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Trending Today Ranked List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Trending today',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _trendingToday.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final trend = _trendingToday[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  trend['rank']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: index < 3 ? AppColors.accent : AppColors.textMuted,
                  ),
                ),
                title: Text(
                  trend['title']!,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    trend['change']!,
                    style: const TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                onTap: () => _submitSearch(trend['title']!),
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // Screen 10 Search Suggestions Live View
  Widget _buildSuggestionsView() {
    final suggestions = [
      {'title': _query, 'count': '3 products'},
      {'title': 'women smart $_query', 'count': '1 product'},
      {'title': 'sport smart $_query', 'count': '1 product'},
      {'title': 'smart $_query bluetooth', 'count': '1 product'},
      {'title': '$_query in Watches', 'count': 'Category'},
    ];

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        // AI Suggestion Banner
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RozioAiScreen()),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.08),
                  const Color(0xFF8B5CF6).withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: AppColors.primary, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Ask Rozio AI about “$_query”',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.primary),
              ],
            ),
          ),
        ),

        // Autocomplete Rows
        ...suggestions.map((s) => ListTile(
          leading: const Icon(Icons.search, size: 18, color: AppColors.textSecondary),
          title: Text(
            s['title']!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          trailing: Text(
            s['count']!,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
          onTap: () => _submitSearch(s['title']!),
        )),

        const Divider(height: 24),

        // Quick Products Found Preview
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Products', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              Text('3 found', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),

        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=200&auto=format&fit=crop',
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          title: const Text('Women Smart Watch, Rose Gold Mesh', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          subtitle: const Text('4.7 · Global Tech', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          trailing: const Text('\$495', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
          onTap: () => _submitSearch('Women Smart Watch, Rose Gold Mesh'),
        ),
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=200&auto=format&fit=crop',
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          title: const Text('Sport Smart Watch, Ocean Band', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          subtitle: const Text('4.6 · Global Tech', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          trailing: const Text('\$89', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
          onTap: () => _submitSearch('Sport Smart Watch, Ocean Band'),
        ),
      ],
    );
  }
}
