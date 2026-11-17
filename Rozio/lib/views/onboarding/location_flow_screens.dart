import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/location_provider.dart';
import '../main_navigation_screen.dart';

// Screen A03: Location Permission Intro
class LocationIntroScreen extends StatelessWidget {
  const LocationIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
              );
            },
            child: const Text('Skip', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 36),
              ),
              const SizedBox(height: 24),
              const Text(
                'Where should we deliver?',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.textPrimary, letterSpacing: -0.5),
              ),
              const SizedBox(height: 8),
              const Text(
                'We use your pincode to show delivery dates, cash on delivery, and stores near you.',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary, height: 1.4),
              ),
              const SizedBox(height: 32),
              // Use current location CTA
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.my_location_rounded, color: Colors.white),
                  label: const Text('Use my current location', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  onPressed: () => _showPermissionDialog(context),
                ),
              ),
              const SizedBox(height: 14),
              // Enter pincode manually
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ManualPincodeScreen()),
                    );
                  },
                  child: const Text('Enter pincode manually', style: TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  'Used only for delivery. Never shared with sellers.',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Allow “Rozio” to use your location?', textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        content: const Text(
          'Rozio uses your location to show delivery dates and cash on delivery for your address.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowDirection: VerticalDirection.down,
        actions: [
          const Divider(height: 1),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationFoundScreen()),
              );
            },
            child: const Text('Allow While Using App', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
          ),
          const Divider(height: 1),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationFoundScreen()),
              );
            },
            child: const Text('Allow Once', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          ),
          const Divider(height: 1),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Don’t Allow', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textMuted)),
          ),
        ],
      ),
    );
  }
}

// Screen A05: Location Found (Confirm location)
class LocationFoundScreen extends StatelessWidget {
  const LocationFoundScreen({super.key});

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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mock Map preview container
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.map_rounded, size: 80, color: Color(0xFFCBD5E1)),
                    Positioned(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4)),
                              ],
                            ),
                            child: const Text('Your order will be delivered here', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 4),
                          const Icon(Icons.location_on, color: AppColors.primary, size: 36),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('CONFIRM DELIVERY LOCATION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primary, letterSpacing: 1.2)),
              const SizedBox(height: 8),
              const Text('Andheri West', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              const Text('Flat 12B, Sea View Apartments, Link Road, Mumbai 400053', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.3)),
              const SizedBox(height: 20),
              // Perks
              Row(
                children: const [
                  Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 16),
                  SizedBox(width: 8),
                  Text('Delivery by Thu, Oct 29', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 16),
                  SizedBox(width: 8),
                  Text('Cash on delivery available', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    context.read<LocationProvider>().setPincode('400053');
                    context.read<LocationProvider>().setCity('Andheri West, Mumbai');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
                      (r) => false,
                    );
                  },
                  child: const Text('Confirm and continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen A06: Location Pincode (Manual entry)
class ManualPincodeScreen extends StatefulWidget {
  const ManualPincodeScreen({super.key});

  @override
  State<ManualPincodeScreen> createState() => _ManualPincodeScreenState();
}

class _ManualPincodeScreenState extends State<ManualPincodeScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isNotDelivered = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _checkPincode() {
    final pin = _pinController.text.trim();
    if (pin.length < 6) return;

    if (pin == '799001' || pin.startsWith('99')) {
      setState(() => _isNotDelivered = true);
    } else {
      context.read<LocationProvider>().setPincode(pin);
      context.read<LocationProvider>().setCity('Mumbai');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        (r) => false,
      );
    }
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter your pincode', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              const SizedBox(height: 6),
              const Text('Six digits, as on your address. You can add the full address at checkout.', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 4),
                decoration: InputDecoration(
                  hintText: '400053',
                  hintStyle: const TextStyle(color: AppColors.textMuted, letterSpacing: 4),
                  filled: true,
                  fillColor: AppColors.surfaceLight,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                ),
                onChanged: (val) {
                  if (val.length == 6) _checkPincode();
                },
              ),
              const SizedBox(height: 12),
              // Screen A07 Not delivered warning state
              if (_isNotDelivered) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.info_outline_rounded, color: Colors.red, size: 20),
                          const SizedBox(width: 8),
                          Text('We don’t deliver to ${_pinController.text} yet', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'You can still browse and save items. We’ll notify you when delivery starts in your area.',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
                            (r) => false,
                          );
                        },
                        child: const Text('Browse anyway', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.my_location_rounded, size: 16, color: AppColors.primary),
                label: const Text('Use current location instead', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13)),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _checkPincode,
                  child: const Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
