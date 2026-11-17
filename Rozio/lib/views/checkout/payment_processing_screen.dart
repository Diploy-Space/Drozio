import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/cart_provider.dart';
import 'order_placed_screen.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final double amount;
  final String method;
  final Map<String, String> address;

  const PaymentProcessingScreen({
    super.key,
    required this.amount,
    required this.method,
    required this.address,
  });

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  int _step = 0;
  final List<String> _steps = [
    'Connecting to secure banking gateway...',
    'Authorizing payment transaction...',
    'Allocating inventory & generating invoice...',
    'Order confirmed!',
  ];

  @override
  void initState() {
    super.initState();
    _startFlow();
  }

  void _startFlow() {
    Timer(const Duration(milliseconds: 700), () {
      if (mounted) setState(() => _step = 1);
    });
    Timer(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _step = 2);
    });
    Timer(const Duration(milliseconds: 2300), () {
      if (mounted) setState(() => _step = 3);
    });
    Timer(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      // Clear shopping cart
      context.read<CartProvider>().clearCart();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderPlacedScreen(
            orderId: 'ROZ-84920',
            amount: widget.amount,
            address: widget.address,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation while processing
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Spinner
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      const Icon(Icons.lock_rounded, size: 36, color: AppColors.primary),
                    ],
                  ),
                  const SizedBox(height: 32),

                  const Text(
                    'Processing payment',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Paying \$${widget.amount.toStringAsFixed(0)} securely',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                  const SizedBox(height: 32),

                  // Progress Step Text
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _steps[_step],
                      key: ValueKey<int>(_step),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Warning note
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.info_outline_rounded, size: 16, color: AppColors.textMuted),
                        SizedBox(width: 8),
                        Text(
                          'Please do not press back or refresh',
                          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
