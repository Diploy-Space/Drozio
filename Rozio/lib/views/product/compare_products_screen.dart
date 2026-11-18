import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import '../../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CompareProductsScreen extends StatefulWidget {
  final ProductModel baseProduct;

  const CompareProductsScreen({
    super.key,
    required this.baseProduct,
  });

  @override
  State<CompareProductsScreen> createState() => _CompareProductsScreenState();
}

class _CompareProductsScreenState extends State<CompareProductsScreen> {
  bool _showOnlyDifferences = false;

  late final List<ProductModel> _comparedProducts;

  @override
  void initState() {
    super.initState();
    _comparedProducts = [
      widget.baseProduct,
      const ProductModel(
        id: 'comp_2',
        title: 'Nova AMOLED Smartwatch',
        storeName: 'Urban Tech Co',
        price: 89,
        originalPrice: 129,
        imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400',
        rating: 4.6,
        reviewsCount: 140,
      ),
      const ProductModel(
        id: 'comp_3',
        title: 'Sport Smart Watch Ocean',
        storeName: 'Global Tech',
        price: 150,
        originalPrice: 180,
        imageUrl: 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=400',
        rating: 4.4,
        reviewsCount: 75,
      ),
    ];
  }

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
          'Compare products',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Switch for differences
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Show only differences',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary),
                ),
                Switch(
                  value: _showOnlyDifferences,
                  activeThumbColor: AppColors.primary,
                  onChanged: (val) => setState(() => _showOnlyDifferences = val),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),

            // 3-Column Comparison Table
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1.2),
                1: FlexColumnWidth(1.2),
                2: FlexColumnWidth(1.2),
              },
              children: [
                // Product Cards Row
                TableRow(
                  children: _comparedProducts.asMap().entries.map((entry) {
                    final index = entry.key;
                    final p = entry.value;
                    final isBestValue = index == 0;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isBestValue ? AppColors.primary : AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isBestValue)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              margin: const EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('BEST VALUE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                            ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(p.imageUrl, height: 70, width: double.infinity, fit: BoxFit.cover),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            p.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                          const SizedBox(height: 4),
                          Text('\$${p.price.toInt()}', style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary, fontSize: 13)),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                // Rating row
                TableRow(
                  children: _comparedProducts.map((p) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text('${p.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  )).toList(),
                ),

                // Warranty row
                const TableRow(
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('2 Years', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF10B981))))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('1 Year', style: TextStyle(fontSize: 12)))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('1 Year', style: TextStyle(fontSize: 12)))),
                  ],
                ),

                // Delivery speed row
                const TableRow(
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('Tomorrow', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF10B981))))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('2 Days', style: TextStyle(fontSize: 12)))),
                    Padding(padding: EdgeInsets.all(8), child: Center(child: Text('3 Days', style: TextStyle(fontSize: 12)))),
                  ],
                ),

                // Action Buttons Row
                TableRow(
                  children: _comparedProducts.map((p) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        context.read<CartProvider>().addCartItem(
                          CartItemModel(
                            product: p,
                            selectedColor: p.availableColors.first,
                            selectedEdition: p.availableEditions.first,
                            quantity: 1,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added ${p.title} to bag!')),
                        );
                      },
                      child: const Text('Add to bag', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  )).toList(),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
