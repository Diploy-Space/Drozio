import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'brand_detail_screen.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = '';

  final List<Map<String, String>> _featuredBrands = [
    {'name': 'Aurel', 'category': 'Jewellery', 'followers': '18.2k followers', 'color': '0xFFD97706'},
    {'name': 'Hanover', 'category': 'Electronics', 'followers': '24.6k followers', 'color': '0xFF2563EB'},
    {'name': 'Kestrel', 'category': 'Watches', 'followers': '9.8k followers', 'color': '0xFF0D9488'},
    {'name': 'Nordhaus', 'category': 'Home and furniture', 'followers': '7.1k followers', 'color': '0xFF7C3AED'},
  ];

  final List<Map<String, String>> _allBrands = [
    {'name': 'Aurel', 'info': 'Jewellery · 3 products', 'followers': '18.2k followers'},
    {'name': 'Hanover', 'info': 'Electronics · 3 products', 'followers': '24.6k followers'},
    {'name': 'Kestrel', 'info': 'Watches · 3 products', 'followers': '9.8k followers'},
    {'name': 'Nordhaus', 'info': 'Home and furniture · 2 products', 'followers': '7.1k followers'},
    {'name': 'Pulse', 'info': 'Audio · 2 products', 'followers': '11.4k followers'},
    {'name': 'Stride', 'info': 'Footwear and fashion · 3 products', 'followers': '15.9k followers'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _allBrands.where((b) {
      return b['name']!.toLowerCase().contains(_filter.toLowerCase()) ||
          b['info']!.toLowerCase().contains(_filter.toLowerCase());
    }).toList();

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
            Text('Brands', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800)),
            Text('Official brand stores on Rozio', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Search 6 brands',
                        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onChanged: (val) => setState(() => _filter = val),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Featured Brands Grid
            const Text(
              'Featured brands',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _featuredBrands.length,
              itemBuilder: (context, index) {
                final brand = _featuredBrands[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BrandDetailScreen(
                          brandName: brand['name']!,
                          category: brand['category']!,
                          followers: brand['followers']!,
                        ),
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          brand['name']!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          brand['category']!,
                          style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          brand['followers']!,
                          style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // All Brands A to Z
            const Text(
              'All brands, A to Z',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredList.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final brand = filteredList[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Text(
                      brand['name']![0],
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    brand['name']!,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  subtitle: Text(
                    brand['info']!,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BrandDetailScreen(
                          brandName: brand['name']!,
                          category: brand['info']!.split('·')[0].trim(),
                          followers: brand['followers']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
