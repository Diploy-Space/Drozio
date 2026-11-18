import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../search/search_results_screen.dart';

class TopStoresScreen extends StatefulWidget {
  const TopStoresScreen({super.key});

  @override
  State<TopStoresScreen> createState() => _TopStoresScreenState();
}

class _TopStoresScreenState extends State<TopStoresScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Following', 'Electronics', 'Fashion', 'Jewellery'];

  final List<Map<String, dynamic>> _stores = [
    {
      'name': 'Rozio Store',
      'rank': '#1 in Jewellery',
      'badge1': 'Ships in 24 hours',
      'badge2': 'Hallmarked gold',
      'rating': 4.75,
      'stats': '194 products · 12.4k followers',
      'avatar': 'R',
      'avatarColor': AppColors.primary,
      'isFollowing': true,
    },
    {
      'name': 'Hanover Electronics',
      'rank': '#2 in Electronics',
      'badge1': 'Brand warranty',
      'badge2': 'Free installation',
      'rating': 4.6,
      'stats': 'New · 86 products · 8.2k followers',
      'avatar': 'H',
      'avatarColor': const Color(0xFF10B981),
      'isFollowing': false,
    },
    {
      'name': 'Glow Audio',
      'rank': '#1 in Audio',
      'badge1': '98% on time',
      'badge2': 'Easy returns',
      'rating': 4.7,
      'stats': '54 products · 15.6k followers',
      'avatar': 'G',
      'avatarColor': AppColors.accent,
      'isFollowing': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top stores',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
            ),
            Text(
              'Verified sellers on Rozio',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              itemCount: _categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Stores List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: _stores.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final store = _stores[index];
                final isFollowing = store['isFollowing'] as bool;

                return Container(
                  padding: const EdgeInsets.all(16),
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
                      // Top Row: Avatar, Store info, Follow Button
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: store['avatarColor'] as Color,
                            child: Text(
                              store['avatar'] as String,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      store['name'] as String,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.verified_rounded, size: 16, color: AppColors.primary),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${store['rating']} · ${store['stats']}',
                                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: isFollowing ? AppColors.surfaceLight : Colors.white,
                              side: BorderSide(color: isFollowing ? AppColors.border : AppColors.primary),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            onPressed: () {
                              setState(() {
                                store['isFollowing'] = !isFollowing;
                              });
                            },
                            child: Text(
                              isFollowing ? 'Following' : 'Follow',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isFollowing ? AppColors.textSecondary : AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Rank & Perks
                      Wrap(
                        spacing: 8,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              store['rank'] as String,
                              style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              store['badge1'] as String,
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              store['badge2'] as String,
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Visit Store CTA
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.surfaceLight,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SearchResultsScreen(query: store['name'] as String),
                              ),
                            );
                          },
                          child: const Text(
                            'Visit store',
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
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
