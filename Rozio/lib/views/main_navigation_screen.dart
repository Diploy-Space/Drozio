import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../providers/cart_provider.dart';
import 'cart/cart_screen.dart';
import 'home/home_screen.dart';
import 'orders/orders_screen.dart';
import 'reels/reels_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    _PlaceholderCategoriesScreen(),
    ReelsScreen(),
    CartScreen(),
    OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final isReels = _currentIndex == 2;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: isReels
                  ? const Color(0xE61E293B)
                  : const Color(0xF20F172A),
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, Icons.home_outlined),
                _buildNavItem(1, Icons.grid_view_rounded, Icons.grid_view_outlined),
                _buildCenterReelsItem(2),
                _buildCartNavItem(3, cart.itemCount),
                _buildNavItem(4, Icons.description_rounded, Icons.description_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon) {
    final isSelected = _currentIndex == index;
    return IconButton(
      icon: Icon(
        isSelected ? activeIcon : inactiveIcon,
        color: isSelected ? Colors.white : Colors.white60,
        size: 24,
      ),
      onPressed: () => setState(() => _currentIndex = index),
    );
  }

  Widget _buildCenterReelsItem(int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.play_arrow_rounded,
            size: 26,
            color: isSelected ? AppColors.textPrimary : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCartNavItem(int index, int badgeCount) {
    final isSelected = _currentIndex == index;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(
            isSelected ? Icons.shopping_bag_rounded : Icons.shopping_bag_outlined,
            color: isSelected ? Colors.white : Colors.white60,
            size: 24,
          ),
          onPressed: () => setState(() => _currentIndex = index),
        ),
        if (badgeCount > 0)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFFEF4444),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$badgeCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _PlaceholderCategoriesScreen extends StatelessWidget {
  const _PlaceholderCategoriesScreen();

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Electronics', 'icon': Icons.headphones_rounded},
      {'name': 'Mobiles', 'icon': Icons.phone_android_rounded},
      {'name': 'Fashion', 'icon': Icons.checkroom_rounded},
      {'name': 'Home Living', 'icon': Icons.chair_rounded},
      {'name': 'Beauty & Care', 'icon': Icons.spa_rounded},
      {'name': 'Gaming', 'icon': Icons.sports_esports_rounded},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Categories', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.3,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cat['icon'] as IconData, size: 36, color: AppColors.primary),
                const SizedBox(height: 8),
                Text(
                  cat['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
