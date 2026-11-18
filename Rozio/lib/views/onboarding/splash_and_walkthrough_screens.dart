import 'dart:async';
import 'package:flutter/material.dart';
import '../auth/login_bottom_sheet.dart';
import 'language_selection_screen.dart';

/// Artboard ID 119:14531 - Main Brand Splash Screen ('Background')
/// Clean white canvas with iconic 'Rozio.' logo, blue progress indicator pill, and home indicator.
class RozioSplashScreen extends StatefulWidget {
  final bool autoNavigate;

  const RozioSplashScreen({
    super.key,
    this.autoNavigate = true,
  });

  @override
  State<RozioSplashScreen> createState() => _RozioSplashScreenState();
}

class _RozioSplashScreenState extends State<RozioSplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    _animController.forward();

    if (widget.autoNavigate) {
      _navTimer = Timer(const Duration(milliseconds: 2400), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, anim, secAnim) =>
                const RozioOnboardingWalkthroughScreen(),
            transitionsBuilder: (context, animation, secAnim, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _proceed() {
    _navTimer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RozioOnboardingWalkthroughScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Center: Rozio. logo
            Center(
              child: InkWell(
                onTap: _proceed,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: AnimatedBuilder(
                  animation: _animController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              'Rozio',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                letterSpacing: -2.0,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1D4ED8),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bottom loading pill indicator (matching Figma Background artboard)
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: Center(
                child: Container(
                  width: 52,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedBuilder(
                      animation: _animController,
                      builder: (context, _) {
                        return Container(
                          width: 22 + (26 * _animController.value),
                          height: 4.5,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D4ED8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // iOS / Android Home indicator
            Positioned(
              left: 0,
              right: 0,
              bottom: 8,
              child: Center(
                child: Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Onboarding Walkthrough Screens matching exact Figma artboards:
/// 1. 'Rozio · Discover splash'
/// 2. 'Rozio · Wholesale splash'
/// 3. 'Rozio · Fast delivery splash'
class RozioOnboardingWalkthroughScreen extends StatefulWidget {
  final int initialPage;

  const RozioOnboardingWalkthroughScreen({
    super.key,
    this.initialPage = 0,
  });

  @override
  State<RozioOnboardingWalkthroughScreen> createState() =>
      _RozioOnboardingWalkthroughScreenState();
}

class _RozioOnboardingWalkthroughScreenState
    extends State<RozioOnboardingWalkthroughScreen> {
  late final PageController _pageController;
  late int _currentPage;

  final List<Map<String, dynamic>> _slides = [
    {
      'headline': 'Your next great\nfind starts here',
      'supporting':
          'Discover your favourite stores and everyday\nessentials, all in one place.',
      'image':
          'https://images.unsplash.com/photo-1542838132-92c53300491e?w=800&auto=format&fit=crop',
      'hasBadge': false,
    },
    {
      'headline': 'Buy stock for your\nshop at factory prices',
      'supporting':
          'Order from 100 pieces straight from\nmanufacturers, with a GST invoice every\ntime.',
      'image':
          'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&auto=format&fit=crop',
      'hasBadge': false,
    },
    {
      'headline': 'Daily needs at your\ndoor in 30 minutes',
      'supporting':
          'Groceries and essentials from shops near\nyou, tracked until they arrive.',
      'image':
          'https://images.unsplash.com/photo-1617347454431-f49d7ff5c3b1?w=800&auto=format&fit=crop',
      'hasBadge': true,
      'badgeText': '30\nmin',
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finishWalkthrough();
    }
  }

  void _finishWalkthrough() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LanguageSelectionScreen()),
    );
  }

  void _openLogin() {
    LoginBottomSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Rozio. on the left, Skip on the right
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 10),
              child: Row(
                children: [
                  // Rozio. logo
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text(
                        'Rozio',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                          letterSpacing: -1.0,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Container(
                        width: 6.5,
                        height: 6.5,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1D4ED8),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Skip button
                  GestureDetector(
                    onTap: _finishWalkthrough,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  final hasBadge = slide['hasBadge'] as bool;

                  return Column(
                    children: [
                      // Hero Photo Container with fade-to-white gradient at bottom
                      Expanded(
                        flex: 12,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              slide['image'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: const Color(0xFFF8FAFC),
                                child: const Center(
                                  child: Icon(Icons.shopping_bag_outlined,
                                      size: 56, color: Color(0xFFCBD5E1)),
                                ),
                              ),
                            ),
                            // Smooth gradient overlay to white background
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              height: 120,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withValues(alpha: 0.0),
                                      Colors.white.withValues(alpha: 0.8),
                                      Colors.white,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Floating 30 min stopwatch badge on Slide 3
                            if (hasBadge)
                              Positioned(
                                top: 50,
                                right: 38,
                                child: Container(
                                  width: 68,
                                  height: 68,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF16A34A),
                                      width: 3.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.15),
                                        blurRadius: 16,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '30',
                                          style: TextStyle(
                                            color: Color(0xFF16A34A),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            height: 1.0,
                                          ),
                                        ),
                                        Text(
                                          'min',
                                          style: TextStyle(
                                            color: Color(0xFF16A34A),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            height: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Welcome Headline + Supporting copy
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: slide['headline'] as String,
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF0F172A),
                                    height: 1.22,
                                    letterSpacing: -0.6,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: '.',
                                      style: TextStyle(color: Color(0xFF1D4ED8)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                slide['supporting'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF64748B),
                                  height: 1.45,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Bottom Area: Circular Pagination Dots, Blue Next Button, Login prompt
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 3 Circular dots
                      Row(
                        children: List.generate(_slides.length, (i) {
                          final isActive = i == _currentPage;
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF1D4ED8)
                                  : const Color(0xFFCBD5E1),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),

                      // Solid Blue Next Circular Button (Figma matching)
                      GestureDetector(
                        onTap: _onNext,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D4ED8),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1D4ED8)
                                    .withValues(alpha: 0.35),
                                blurRadius: 14,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // "I already have an account. Log in"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'I already have an account. ',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: _openLogin,
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Home indicator
                  Container(
                    width: 134,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
