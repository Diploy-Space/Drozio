import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';

class RatingsReviewsScreen extends StatelessWidget {
  final ProductModel product;

  const RatingsReviewsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        'author': 'Priya Sharma',
        'rating': 5,
        'date': 'Oct 22, 2026',
        'verified': true,
        'text': 'The build quality and sound separation is astonishing for this price point. Arrived in Mumbai in just 2 days with full gift packaging.',
        'photos': [
          'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=200',
        ],
      },
      {
        'author': 'Karan Malhotra',
        'rating': 4,
        'date': 'Oct 18, 2026',
        'verified': true,
        'text': 'ANC works very well in trains and noisy cafes. Battery lasts around 28 hours with the case.',
        'photos': [],
      },
      {
        'author': 'Sneha Rao',
        'rating': 5,
        'date': 'Oct 12, 2026',
        'verified': true,
        'text': 'Obsessed with the design and aesthetic! Everyone asked me where I bought this from.',
        'photos': [],
      },
    ];

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
          'Ratings & Reviews',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating Breakdown Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  // Overall Score
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                      ),
                      Row(
                        children: List.generate(5, (index) => Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: index < product.rating.floor() ? Colors.amber : Colors.grey.shade300,
                        )),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${product.reviewsCount} verified reviews',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  // Progress Bars
                  Expanded(
                    child: Column(
                      children: [
                        _buildRatingBar('5★', 0.82),
                        _buildRatingBar('4★', 0.12),
                        _buildRatingBar('3★', 0.04),
                        _buildRatingBar('2★', 0.01),
                        _buildRatingBar('1★', 0.01),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Customer Reviews List
            const Text(
              'Customer Reviews',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),

            ...reviews.map((r) => Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r['author'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      Text(
                        r['date'] as String,
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (i) => Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: i < (r['rating'] as int) ? Colors.amber : Colors.grey.shade300,
                        )),
                      ),
                      const SizedBox(width: 8),
                      if (r['verified'] as bool)
                        const Row(
                          children: [
                            Icon(Icons.verified, size: 12, color: Color(0xFF10B981)),
                            SizedBox(width: 2),
                            Text('Verified Buyer', style: TextStyle(fontSize: 10, color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    r['text'] as String,
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(String star, double fraction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(star, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: 6,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
