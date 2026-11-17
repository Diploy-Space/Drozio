import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/reel_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/reel_provider.dart';
import '../product/product_detail_sheet.dart';
import 'shop_this_video_sheet.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  bool _isPaused = false;
  bool _isMuted = false;
  final TextEditingController _commentController = TextEditingController();

  final List<Map<String, String>> _liveComments = [
    {'user': 'Ananya', 'text': 'Is the diamond certified hallmarked?'},
    {'user': 'Rohan99', 'text': 'How long does delivery take to Mumbai?'},
    {'user': 'Pooja_S', 'text': 'Looks gorgeous! Buying the necklace now 💎'},
    {'user': 'Vikram', 'text': 'Does it come in rose gold edition?'},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
  }

  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isMuted ? 'Sound off' : 'Sound on'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reelProvider = context.watch<ReelProvider>();
    final reels = reelProvider.reels;
    final currentTab = reelProvider.currentTab;

    // Screen 27: Following empty state
    if (currentTab == ReelTab.following) {
      final followingReels = reels.where((r) => r.isFollowing).toList();
      if (followingReels.isEmpty) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                _buildTopHeader(reelProvider, reels.length),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_add_alt_1_outlined, color: Colors.white, size: 48),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'No following reels yet',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Follow stores you love on For You or Discover to see their latest shoppable reels here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          onPressed: () => reelProvider.setTab(ReelTab.forYou),
                          child: const Text('Back to For You', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    // Screen 28: Live Stream View
    if (currentTab == ReelTab.live) {
      final liveReel = reels.first;
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Live Stream video mockup
            Image.network(
              liveReel.videoThumbnail,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent, Colors.black87],
                  stops: [0.0, 0.4, 0.9],
                ),
              ),
            ),

            // Top Header with Live Badge & Viewers
            SafeArea(
              child: Column(
                children: [
                  _buildTopHeader(reelProvider, reels.length),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.circle, color: Colors.white, size: 8),
                              SizedBox(width: 4),
                              Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.remove_red_eye_outlined, color: Colors.white70, size: 12),
                              SizedBox(width: 4),
                              Text('34 watching', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(_isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded, color: Colors.white),
                          onPressed: _toggleMute,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Live Comments Stream (Screen 28)
            Positioned(
              left: 16,
              right: 80,
              bottom: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _liveComments.map((c) => Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${c['user']}: ',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF38BDF8)),
                        ),
                        TextSpan(
                          text: c['text'],
                          style: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ),

            // Live Pinned Product Card (Screen 28)
            Positioned(
              left: 16,
              right: 16,
              bottom: 60,
              child: _buildProductDock(context, liveReel),
            ),
          ],
        ),
      );
    }

    // Default: Shoppable Reels Player (Screen 24 & Screen 29)
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Vertical PageView
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: reels.length,
            onPageChanged: (index) {
              reelProvider.setReelIndex(index);
              setState(() => _isPaused = false);
            },
            itemBuilder: (context, index) {
              final reel = reels[index];
              return GestureDetector(
                onTap: _togglePause,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Video Thumbnail
                    Image.network(
                      reel.videoThumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(color: const Color(0xFF0F172A)),
                    ),

                    // Gradient
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

                    // Paused Indicator Overlay (Screen 29)
                    if (_isPaused)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
                        ),
                      ),

                    // Hotspot on video
                    Positioned(
                      left: MediaQuery.of(context).size.width * reel.hotspotXPercent,
                      top: MediaQuery.of(context).size.height * reel.hotspotYPercent,
                      child: GestureDetector(
                        onTap: () => ProductDetailSheet.show(context, reel.product),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
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
                              const Icon(Icons.shopping_bag, size: 14, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(
                                '\$${reel.product.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Right Action Bar
                    Positioned(
                      right: 12,
                      bottom: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Like
                          GestureDetector(
                            onTap: () => reelProvider.toggleLike(reel.id),
                            child: Column(
                              children: [
                                Icon(
                                  reel.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  color: reel.isLiked ? const Color(0xFFEF4444) : Colors.white,
                                  size: 32,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${(reel.likesCount / 1000).toStringAsFixed(1)}k',
                                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Comment
                          Column(
                            children: [
                              const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 28),
                              const SizedBox(height: 4),
                              Text(
                                '${reel.commentsCount}',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Save / Bookmark
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
                                const Text('Save', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Share
                          const Column(
                            children: [
                              Icon(Icons.reply_rounded, color: Colors.white, size: 30),
                              SizedBox(height: 4),
                              Text('Share', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Bottom Left Store info & caption
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
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
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
                                    color: reel.isFollowing ? Colors.white.withValues(alpha: 0.2) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                                  ),
                                  child: Text(
                                    reel.isFollowing ? 'Following' : 'Follow',
                                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
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
                            style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.3),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.music_note_rounded, size: 14, color: Colors.white70),
                              const SizedBox(width: 6),
                              Text(reel.audioTitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Bottom Floating Product Banner Dock (Screen 24 & Screen 30)
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 60,
                      child: _buildProductDock(context, reel),
                    ),
                  ],
                ),
              );
            },
          ),

          // Top Header (Tabs, Sound toggle, Progress bars)
          SafeArea(
            child: _buildTopHeader(reelProvider, reels.length),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(ReelProvider reelProvider, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Story-style progress bars
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: List.generate(count, (index) {
              return Expanded(
                child: Container(
                  height: 2.5,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: index <= reelProvider.activeReelIndex
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),

        // Tabs Row: Following, For You, Live & Sound
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabItem(reelProvider, 'Following', ReelTab.following),
              const SizedBox(width: 16),
              _buildTabItem(reelProvider, 'For you', ReelTab.forYou),
              const SizedBox(width: 16),
              _buildTabItem(reelProvider, '• Live', ReelTab.live),
              const Spacer(),
              IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: _toggleMute,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(ReelProvider provider, String title, ReelTab tab) {
    final isSelected = provider.currentTab == tab;
    return GestureDetector(
      onTap: () => provider.setTab(tab),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              width: 20,
              height: 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductDock(BuildContext context, ReelModel reel) {
    return Container(
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
          // Tagged products grid button (Screen 30: Shop this video)
          GestureDetector(
            onTap: () {
              ShopThisVideoSheet.show(context, [
                reel.product,
                const ProductModel(
                  id: 'reel_tag_2',
                  title: 'Matching 18K Diamond Studs',
                  storeName: 'Rozio Store',
                  price: 450,
                  originalPrice: 600,
                  imageUrl: 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=400',
                ),
              ]);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(Icons.grid_view_rounded, size: 20, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: 8),

          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              reel.product.imageUrl,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),

          // Details
          Expanded(
            child: GestureDetector(
              onTap: () => ProductDetailSheet.show(context, reel.product),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reel.product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '\$${reel.product.price.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '\$${reel.product.originalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted, decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Add to Bag CTA
          ElevatedButton.icon(
            onPressed: () {
              context.read<CartProvider>().addCartItem(
                CartItemModel(
                  product: reel.product,
                  selectedColor: reel.product.availableColors.first,
                  selectedEdition: reel.product.availableEditions.first,
                  quantity: 1,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added ${reel.product.title} to bag!'),
                  backgroundColor: AppColors.primary,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.shopping_bag_outlined, size: 14, color: Colors.white),
            label: const Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

// Screen 27: Following, empty state
class EmptyFollowingReelsScreen extends StatelessWidget {
  const EmptyFollowingReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Following', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_add_alt_1_rounded, size: 54, color: Colors.white70),
              ),
              const SizedBox(height: 24),
              const Text(
                'No creators followed yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Follow stores and video creators to see their exclusive drops and live shopping events here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white60, height: 1.4),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Explore For You Reels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen 29: Paused, sound on
class PausedReelsScreen extends StatelessWidget {
  const PausedReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800&auto=format&fit=crop',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.45),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.volume_up_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text('Sound on', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 44),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Pro Wireless Earbuds ANC', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                SizedBox(height: 4),
                Text('Paused · Tap anywhere to resume playback', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

