import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Orders & Activity',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildOrderCard(
            context,
            id: 'RZ-83921',
            date: 'Today, 2:45 PM',
            title: 'Pro Wireless Earbuds ANC',
            store: 'Glow Audio',
            price: 59,
            status: 'Shipped · Arriving Thu, Oct 29',
            statusColor: const Color(0xFF16A34A),
            imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400',
          ),
          const SizedBox(height: 12),
          _buildOrderCard(
            context,
            id: 'RZ-77120',
            date: 'Oct 24, 2026',
            title: 'Nova AMOLED Smartwatch',
            store: 'Urban Tech Co',
            price: 89,
            status: 'Delivered',
            statusColor: AppColors.textSecondary,
            imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400',
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String id,
    required String date,
    required String title,
    required String store,
    required double price,
    required String status,
    required Color statusColor,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order #$id', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textSecondary)),
              Text(date, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
          const Divider(height: 20, thickness: 0.8),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, width: 64, height: 64, fit: BoxFit.cover),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(store, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                    Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text('\$${price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_shipping_outlined, size: 14, color: statusColor),
                const SizedBox(width: 6),
                Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
