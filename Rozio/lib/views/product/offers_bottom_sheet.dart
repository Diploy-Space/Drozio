import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class OffersBottomSheet extends StatelessWidget {
  const OffersBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const OffersBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final offers = [
      {
        'bank': 'HDFC Bank Credit Card',
        'desc': 'Flat 10% instant discount up to \$25 on orders above \$100',
        'code': 'HDFC10',
      },
      {
        'bank': 'ICICI Bank Net Banking',
        'desc': 'Get \$15 cashback on orders over \$75 using ICICI payment',
        'code': 'ICICI15',
      },
      {
        'bank': 'No Cost EMI',
        'desc': 'Available on major credit cards for orders above \$150. Starting at \$25/month.',
        'code': 'EMI',
      },
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Offers & Discounts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),

            ...offers.map((o) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.local_offer_rounded, color: AppColors.primary, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(o['bank']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text(o['desc']!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
