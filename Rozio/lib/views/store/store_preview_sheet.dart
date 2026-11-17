import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'store_chat_screen.dart';
import 'store_detail_screen.dart';

class StorePreviewSheet extends StatefulWidget {
  final String storeName;

  const StorePreviewSheet({
    super.key,
    required this.storeName,
  });

  static void show(BuildContext context, String storeName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => StorePreviewSheet(storeName: storeName),
    );
  }

  @override
  State<StorePreviewSheet> createState() => _StorePreviewSheetState();
}

class _StorePreviewSheetState extends State<StorePreviewSheet> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    widget.storeName[0],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.storeName, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, size: 16, color: AppColors.primary),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text('4.75 ★ · 194 products · 12.4k followers', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Badges
            Wrap(
              spacing: 8,
              children: const [
                Chip(
                  label: Text('Ships in 24 hours', style: TextStyle(fontSize: 11)),
                  backgroundColor: AppColors.surfaceLight,
                ),
                Chip(
                  label: Text('Hallmarked gold', style: TextStyle(fontSize: 11)),
                  backgroundColor: AppColors.surfaceLight,
                ),
                Chip(
                  label: Text('100% Genuine', style: TextStyle(fontSize: 11)),
                  backgroundColor: AppColors.surfaceLight,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Actions: Follow, Chat, Visit
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: _isFollowing ? AppColors.border : AppColors.primary),
                    ),
                    onPressed: () => setState(() => _isFollowing = !_isFollowing),
                    child: Text(
                      _isFollowing ? 'Following' : 'Follow',
                      style: TextStyle(fontWeight: FontWeight.w700, color: _isFollowing ? AppColors.textSecondary : AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => StoreChatScreen(storeName: widget.storeName)),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: AppColors.primary),
                    label: const Text('Chat', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => StoreDetailScreen(storeName: widget.storeName)),
                  );
                },
                child: const Text('Visit store page', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
