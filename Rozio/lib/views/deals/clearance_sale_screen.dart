import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';
import '../product/product_detail_sheet.dart';

class ClearanceSaleScreen extends StatefulWidget {
  const ClearanceSaleScreen({super.key});

  @override
  State<ClearanceSaleScreen> createState() => _ClearanceSaleScreenState();
}

class _ClearanceSaleScreenState extends State<ClearanceSaleScreen> {
  String _selectedFilter = 'All';

  final List<String> _priceFilters = ['All', 'Under \$50', '\$50 to \$200', 'Over \$200'];

  static const List<Map<String, dynamic>> _clearanceItems = [
    {
      'product': ProductModel(
        id: 'clr_1',
        title: '18K White Gold Diamond Necklace',
        storeName: 'Rozio Store',
        price: 1680,
        originalPrice: 2400,
        imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500&auto=format&fit=crop',
        rating: 4.9,
        reviewsCount: 58,
      ),
      'left': 1,
      'discount': '-30%',
    },
    {
      'product': ProductModel(
        id: 'clr_2',
        title: 'Pro Wireless Earbuds ANC',
        storeName: 'Glow Audio',
        price: 59,
        originalPrice: 79,
        imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500&auto=format&fit=crop',
        rating: 4.7,
        reviewsCount: 312,
      ),
      'left': 3,
      'discount': '-25%',
    },
    {
      'product': ProductModel(
        id: 'clr_3',
        title: 'MagSafe Power Bank 10,000 mAh',
        storeName: 'Glow Audio',
        price: 39,
        originalPrice: 49,
        imageUrl: 'https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=500&auto=format&fit=crop',
        rating: 4.5,
        reviewsCount: 96,
      ),
      'left': 6,
      'discount': '-20%',
    },
    {
      'product': ProductModel(
        id: 'clr_4',
        title: 'Smart Watch Bluetooth',
        storeName: 'Hanover Electronics',
        price: 150,
        originalPrice: 180,
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop',
        rating: 4.4,
        reviewsCount: 75,
      ),
      'left': 4,
      'discount': '-17%',
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
        title: const Text(
          'Clearance sale',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Clearance Banner (Screen 17)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF991B1B), Color(0xFFDC2626)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'CLEARANCE SALE · UP TO 25% OFF',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const Text(
                        'Ends Sunday',
                        style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Save more, up to 20% off',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Last pieces from top stores. Prices drop as stock runs out.',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  const SizedBox(height: 14),
                  // Trust pills
                  Row(
                    children: [
                      _buildPill('Last pieces'),
                      const SizedBox(width: 8),
                      _buildPill('Biggest drops'),
                      const SizedBox(width: 8),
                      _buildPill('While stock lasts'),
                    ],
                  ),
                ],
              ),
            ),

            // Price filter pills
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _priceFilters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = _priceFilters[index];
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                      ),
                      child: Text(
                        filter,
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
            const SizedBox(height: 16),

            // Products Grid with Urgent Stock Tags
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _clearanceItems.length,
              itemBuilder: (context, index) {
                final item = _clearanceItems[index];
                final p = item['product'] as ProductModel;
                final left = item['left'] as int;
                final discount = item['discount'] as String;

                return GestureDetector(
                  onTap: () => ProductDetailSheet.show(context, p),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.network(p.imageUrl, fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  discount,
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Only $left left',
                                  style: const TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '\$${p.price.toInt()}',
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primary),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '\$${p.originalPrice.toInt()}',
                                    style: const TextStyle(fontSize: 11, decoration: TextDecoration.lineThrough, color: AppColors.textMuted),
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
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPill(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}
