import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../orders/orders_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedTab = 'All';
  int _unreadCount = 4;

  final List<String> _tabs = ['All', 'Orders', 'Offers', 'Reels'];

  void _markAllRead() {
    setState(() => _unreadCount = 0);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        duration: Duration(seconds: 2),
      ),
    );
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
            ),
            Text(
              _unreadCount > 0 ? '$_unreadCount unread' : 'All caught up',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _tabs.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final tab = _tabs[index];
                final isSelected = _selectedTab == tab;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTab = tab),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                    ),
                    child: Center(
                      child: Text(
                        tab,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pinned Outbid Alert (Screen 23)
                  if (_selectedTab == 'All' || _selectedTab == 'Offers') ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accent.withValues(alpha: 0.1),
                            Colors.amber.withValues(alpha: 0.08),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '2H 14M LEFT TO BID',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.gavel_rounded, color: AppColors.accent, size: 18),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'You have been outbid',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Someone bid \$540 on the Beige Tufted 2-Seater Loveseat.',
                            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              onPressed: () {},
                              child: const Text('Bid again', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // TODAY Group
                  const Text('TODAY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                  const SizedBox(height: 10),

                  // Notification 1: Order Packed
                  _buildNotificationTile(
                    icon: Icons.inventory_2_outlined,
                    iconColor: AppColors.primary,
                    title: 'Your order is packed',
                    time: '10:52 am',
                    body: 'Copper Alloy Inlaid Zircon Round Ring and 1 more ship tomorrow.',
                    actionText: 'Track order',
                    onAction: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersScreen()));
                    },
                  ),
                  const SizedBox(height: 12),

                  // Notification 2: Price Drop
                  _buildNotificationTile(
                    icon: Icons.trending_down_rounded,
                    iconColor: const Color(0xFF10B981),
                    title: 'Price drop on your wishlist',
                    time: '9:30 am',
                    body: '18K White Gold Diamond Necklace is now \$1,680, down from \$2,400.',
                    actionText: 'Buy now',
                    onAction: () {},
                  ),
                  const SizedBox(height: 12),

                  // Notification 3: Rozio Store is Live
                  _buildNotificationTile(
                    icon: Icons.live_tv_rounded,
                    iconColor: Colors.red,
                    title: 'Rozio Store is live',
                    time: '8:05 am',
                    body: 'Styling the 18K white gold set. Join before the stream ends.',
                    actionText: 'Watch live',
                    onAction: () {},
                  ),
                  const SizedBox(height: 24),

                  // EARLIER Group
                  const Text('EARLIER', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                  const SizedBox(height: 10),

                  // Notification 4: Delivered Review
                  _buildNotificationTile(
                    icon: Icons.check_circle_outline_rounded,
                    iconColor: const Color(0xFF10B981),
                    title: 'Delivered: Women Beautiful White Sneakers',
                    time: 'Oct 24',
                    body: 'Rate it to help other shoppers choose.',
                    actionText: 'Rate it',
                    onAction: () {},
                  ),
                  const SizedBox(height: 12),

                  // Notification 5: Promo Code
                  _buildNotificationTile(
                    icon: Icons.local_offer_outlined,
                    iconColor: AppColors.accent,
                    title: 'REEL10 is back this weekend',
                    time: 'Oct 22',
                    body: '10% off orders over \$50, on any store.',
                    actionText: 'Shop now',
                    onAction: () {},
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required String body,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconColor.withValues(alpha: 0.1),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textPrimary),
                      ),
                    ),
                    Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(body, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onAction,
                  child: Text(
                    actionText,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
