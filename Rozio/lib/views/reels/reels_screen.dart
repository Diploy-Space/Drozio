import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/cart_provider.dart';
import '../../providers/reel_provider.dart';
import '../product/product_detail_sheet.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> with SingleTickerProviderStateMixin {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reelProvider = context.watch<ReelProvider>();
    final reels = reelProvider.reels;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fullscreen Vertical PageView
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: reels.length,
            onPageChanged: (index) {
              reelProvider.setReelIndex(index);
            },
            itemBuilder: (context, index) {
              final reel = reels[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Reel Background Image/Video representation
                  Image.network(
                    reel.videoThumbnail,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFF1E293B),
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF0F172A),
                      child: const Center(
                        child: Icon(Icons.videocam_off_outlined, color: Colors.white54, size: 48),
                      ),
                    ),
                  ),

                  // Soft Gradient Overlays for readable text
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.25, 0.6, 1.0],
                          colors: [
                            Color(0x99000000),
                            Color(0x1A000000),
                            Color(0x33000000),
                            Color(0xCC000000),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Interactive Product Hotspot Pin on the video
                  Positioned(
                    left: MediaQuery.of(context).size.width * reel.hotspotXPercent,
                    top: MediaQuery.of(context).size.height * reel.hotspotYPercent,
                    child: GestureDetector(
                      onTap: () => ProductDetailSheet.show(context, reel.product),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.shopping_bag_outlined, size: 14, color: AppColors.textPrimary),
                            const SizedBox(width: 4),
                            Text(
                              '\$${reel.product.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Right Sidebar Action Buttons
                  Positioned(
                    right: 14,
                    bottom: 150,
                    child: Column(
                      children: [
                        // Store Avatar with Follow plus
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(reel.storeAvatar),
                              ),
                            ),
                            if (!reel.isFollowing)
                              Positioned(
                                bottom: -4,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () => reelProvider.toggleFollow(reel.id),
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.add, size: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Like Button
                        GestureDetector(
                          onTap: () => reelProvider.toggleLike(reel.id),
                          child: Column(
                            children: [
                              Icon(
                                reel.isLiked ? Icons.favorite : Icons.favorite_border,
                                color: reel.isLiked ? const Color(0xFFEF4444) : Colors.white,
                                size: 30,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${(reel.likesCount / 1000).toStringAsFixed(1)}k',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Comment Button
                        Column(
                          children: [
                            const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 28),
                            const SizedBox(height: 4),
                            Text(
                              '${reel.commentsCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Bookmark / Save
                        GestureDetector(
                          onTap: () => reelProvider.toggleSave(reel.id),
                          child: Column(
                            children: [
                              Icon(
                                reel.isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
                                color: reel.isSaved ? const Color(0xFFF59E0B) : Colors.white,
                                size: 28,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Share
                        const Column(
                          children: [
                            Icon(Icons.reply_rounded, color: Colors.white, size: 30),
                            SizedBox(height: 4),
                            Text(
                              'Share',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom Left Caption & Store info
                  Positioned(
                    left: 16,
                    right: 80,
                    bottom: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              reel.storeName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (reel.isStoreVerified) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, size: 16, color: Color(0xFF38BDF8)),
                            ],
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => reelProvider.toggleFollow(reel.id),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: reel.isFollowing
                                      ? Colors.white.withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                                ),
                                child: Text(
                                  reel.isFollowing ? 'Following' : 'Follow',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          reel.caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.music_note_rounded, size: 14, color: Colors.white70),
                            const SizedBox(width: 6),
                            Text(
                              reel.audioTitle,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom Floating Product Banner Card
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 74,
                    child: GestureDetector(
                      onTap: () => ProductDetailSheet.show(context, reel.product),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                reel.product.imageUrl,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reel.product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${reel.product.price.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '\$${reel.product.originalPrice.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textMuted,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Add button
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<CartProvider>().addItem(
                                  product: reel.product,
                                  selectedColor: reel.product.availableColors.first,
                                  selectedEdition: reel.product.availableEditions.first,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added ${reel.product.title} to bag!'),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(Icons.shopping_bag_outlined, size: 16, color: Colors.white),
                              label: const Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Top Header (Segment Switcher & Progress Bar)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Multi-segment Story Progress Bars
                  Row(
                    children: List.generate(
                      reels.length,
                      (i) => Expanded(
                        child: Container(
                          height: 2.5,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: i == reelProvider.currentReelIndex
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Floating Segment Bar & Search
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40), // Balance search button
                      // Segment Switcher
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTabItem(context, ReelTab.following, 'Following', reelProvider),
                            _buildTabItem(context, ReelTab.forYou, 'For you', reelProvider),
                            _buildTabItem(context, ReelTab.live, '• Live', reelProvider),
                          ],
                        ),
                      ),
                      // Search button
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                        ),
                        child: const Icon(Icons.search, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    ReelTab tab,
    String label,
    ReelProvider provider,
  ) {
    final isActive = provider.activeTab == tab;

    return GestureDetector(
      onTap: () => provider.setTab(tab),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.textPrimary : Colors.white,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
