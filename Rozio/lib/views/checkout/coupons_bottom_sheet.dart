import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CouponsBottomSheet extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onApply;

  const CouponsBottomSheet({
    super.key,
    required this.onApply,
  });

  static Future<Map<String, dynamic>?> show(BuildContext context) {
    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => CouponsBottomSheet(
        onApply: (coupon) => Navigator.pop(context, coupon),
      ),
    );
  }

  @override
  State<CouponsBottomSheet> createState() => _CouponsBottomSheetState();
}

class _CouponsBottomSheetState extends State<CouponsBottomSheet> {
  final _inputController = TextEditingController();

  final List<Map<String, dynamic>> _coupons = [
    {
      'code': 'REEL10',
      'discountPercent': 10,
      'flatDiscount': 0,
      'minOrder': 50,
      'title': '10% OFF · Shoppable Reels Special',
      'desc': 'Get 10% extra discount on orders above \$50 from reel products. Max discount \$25.',
    },
    {
      'code': 'FIRST5',
      'discountPercent': 0,
      'flatDiscount': 5,
      'minOrder': 25,
      'title': 'SAVE \$5 · First-Order Exclusive',
      'desc': 'Flat \$5 off on your first order on Rozio. Valid for 7 days.',
    },
    {
      'code': 'FESTIVE20',
      'discountPercent': 20,
      'flatDiscount': 0,
      'minOrder': 100,
      'title': '20% OFF · Festive Season Sale',
      'desc': 'Get 20% off on jewellery, fashion & electronics on orders above \$100.',
    },
  ];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _applyManual() {
    final code = _inputController.text.trim().toUpperCase();
    final match = _coupons.firstWhere(
      (c) => c['code'] == code,
      orElse: () => {
        'code': code,
        'discountPercent': 10,
        'flatDiscount': 0,
        'minOrder': 0,
        'title': '$code Applied',
        'desc': 'Special promotional discount',
      },
    );
    widget.onApply(match);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
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
                    'Coupons & Offers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 12),

              // Coupon Input field
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.confirmation_num_outlined, size: 20, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        textCapitalization: TextCapitalization.characters,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Enter coupon code',
                          hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13, fontWeight: FontWeight.normal),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _applyManual,
                      child: const Text('Apply', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Coupons List
              ..._coupons.map((coupon) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.local_offer_rounded, color: AppColors.accent, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  coupon['code'] as String,
                                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(coupon['title'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                          const SizedBox(height: 2),
                          Text(coupon['desc'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => widget.onApply(coupon),
                      child: const Text('Apply', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
