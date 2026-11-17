import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

// Screen 38: Wholesale Tier Saving Sheet
class WholesaleTierSheet extends StatefulWidget {
  final double basePrice;

  const WholesaleTierSheet({super.key, this.basePrice = 59.0});

  static Future<void> show(BuildContext context, {double basePrice = 59.0}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => WholesaleTierSheet(basePrice: basePrice),
    );
  }

  @override
  State<WholesaleTierSheet> createState() => _WholesaleTierSheetState();
}

class _WholesaleTierSheetState extends State<WholesaleTierSheet> {
  int _selectedTierIndex = 1;

  final List<Map<String, dynamic>> _tiers = [
    {'range': '1 – 9 pcs', 'discount': '0%', 'price': 59.0, 'moq': 1},
    {'range': '10 – 49 pcs', 'discount': '17% OFF', 'price': 49.0, 'moq': 10},
    {'range': '50 – 99 pcs', 'discount': '29% OFF', 'price': 42.0, 'moq': 50},
    {'range': '100+ pcs', 'discount': '41% OFF', 'price': 35.0, 'moq': 100},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.storefront_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wholesale Volume Pricing',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    Text(
                      'Direct manufacturer tiered rates with GST tax invoice',
                      style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ..._tiers.asMap().entries.map((entry) {
            final idx = entry.key;
            final t = entry.value;
            final isSel = idx == _selectedTierIndex;

            return GestureDetector(
              onTap: () => setState(() => _selectedTierIndex = idx),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isSel ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSel ? AppColors.primary : const Color(0xFFE2E8F0),
                    width: isSel ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSel ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: isSel ? AppColors.primary : AppColors.textMuted,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t['range'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                          if ((t['discount'] as String) != '0%')
                            Text(
                              t['discount'] as String,
                              style: const TextStyle(color: Color(0xFF16A34A), fontSize: 11, fontWeight: FontWeight.w700),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${(t['price'] as double).toStringAsFixed(2)} / pc',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: isSel ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Select Tier & Add to Bag', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}
