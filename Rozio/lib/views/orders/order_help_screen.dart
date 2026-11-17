import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'support_chat_screen.dart';

class OrderHelpScreen extends StatelessWidget {
  final String orderId;

  const OrderHelpScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final issues = [
      {'title': 'Delivery is delayed', 'icon': Icons.access_time_rounded},
      {'title': 'Change delivery address or phone', 'icon': Icons.location_on_outlined},
      {'title': 'Incorrect or missing item', 'icon': Icons.error_outline_rounded},
      {'title': 'Need invoice or GST bill', 'icon': Icons.receipt_long_outlined},
      {'title': 'Contact courier partner', 'icon': Icons.two_wheeler_rounded},
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
          'Help with this order',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select an issue for Order #$orderId',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),

            ...issues.map((item) => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: Icon(item['icon'] as IconData, color: AppColors.primary),
              title: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SupportChatScreen(orderId: orderId),
                  ),
                );
              },
            )),

            const Spacer(),

            // Chat with support CTA
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SupportChatScreen(orderId: orderId),
                    ),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
                label: const Text('Chat with us', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
