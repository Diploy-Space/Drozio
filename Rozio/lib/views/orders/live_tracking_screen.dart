import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class LiveTrackingScreen extends StatelessWidget {
  final String orderId;

  const LiveTrackingScreen({
    super.key,
    required this.orderId,
  });

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
              'Live tracking',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
            ),
            Text(
              'Order #$orderId',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Simulated Interactive Map Background
          Container(
            color: const Color(0xFFF1F5F9),
            child: Stack(
              children: [
                // Grid/Streets Mockup
                CustomPaint(
                  size: Size.infinite,
                  painter: _MapPainter(),
                ),

                // Destination Pin (User home in Mumbai)
                const Positioned(
                  top: 140,
                  right: 80,
                  child: Column(
                    children: [
                      Icon(Icons.home_filled, color: AppColors.primary, size: 36),
                      Text('Your Address', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                // Courier Partner Live Marker
                const Positioned(
                  top: 260,
                  left: 100,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xFF10B981),
                        child: Icon(Icons.delivery_dining_rounded, color: Colors.white, size: 22),
                      ),
                      Text('Sunil (18 mins away)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Top Floating Status Card
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.two_wheeler_rounded, color: Color(0xFF10B981), size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Out for delivery',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF10B981)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Arriving today by 2:00 PM (18 mins away)',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Courier Partner & OTP Sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Courier Details Row
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200'),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Sunil Verma',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Rozio Express Partner · 4.9 ★ (1,240 deliveries)',
                              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone_rounded, color: AppColors.primary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Delivery OTP reminder
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Doorstep Delivery Code', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('8492', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: AppColors.primary, letterSpacing: 2)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    // Draw background street line
    canvas.drawLine(const Offset(40, 200), Offset(size.width - 40, 200), bgPaint);

    final path = Path();
    // Route from courier (100, 260) to user (width - 80, 140)
    path.moveTo(100, 260);
    path.lineTo(160, 260);
    path.lineTo(160, 180);
    path.lineTo(size.width - 120, 180);
    path.lineTo(size.width - 80, 140);

    // Dotted or solid route
    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
