import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'payment_processing_screen.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  final double totalAmount;
  final Map<String, String> address;

  const CheckoutPaymentScreen({
    super.key,
    required this.totalAmount,
    required this.address,
  });

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  String _selectedMethod = 'upi_gpay'; // upi_gpay, upi_phonepe, card, netbanking, cod
  final _cardCvvController = TextEditingController();
  final _upiIdController = TextEditingController();

  @override
  void dispose() {
    _cardCvvController.dispose();
    _upiIdController.dispose();
    super.dispose();
  }

  void _processPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentProcessingScreen(
          amount: widget.totalAmount,
          method: _selectedMethod,
          address: widget.address,
        ),
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
        title: const Text(
          'Payment',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          // Step Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                _buildStepIndicator('1', 'Address', isDone: true, isActive: false),
                Expanded(child: Container(height: 2, color: AppColors.primary)),
                _buildStepIndicator('2', 'Summary', isDone: true, isActive: false),
                Expanded(child: Container(height: 2, color: AppColors.primary)),
                _buildStepIndicator('3', 'Payment', isDone: false, isActive: true),
              ],
            ),
          ),

          // Total Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              border: Border(bottom: BorderSide(color: AppColors.primary.withValues(alpha: 0.15))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Amount to Pay', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary)),
                Text(
                  '\$${widget.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: AppColors.primary),
                ),
              ],
            ),
          ),

          // Payment Options List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              children: [
                // UPI Section
                const Text('UPI Options', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                const SizedBox(height: 8),

                _buildPaymentTile(
                  id: 'upi_gpay',
                  title: 'Google Pay',
                  subtitle: 'Fastest 1-tap checkout',
                  icon: Icons.account_balance_wallet_rounded,
                  iconColor: const Color(0xFF4285F4),
                ),
                _buildPaymentTile(
                  id: 'upi_phonepe',
                  title: 'PhonePe UPI',
                  subtitle: 'Pay via PhonePe app',
                  icon: Icons.flash_on_rounded,
                  iconColor: const Color(0xFF5F259F),
                ),
                _buildPaymentTile(
                  id: 'upi_paytm',
                  title: 'Paytm UPI',
                  subtitle: 'Pay via Paytm wallet or UPI',
                  icon: Icons.payments_rounded,
                  iconColor: const Color(0xFF00B9F1),
                ),
                const SizedBox(height: 16),

                // Cards Section (Screen 53)
                const Text('Cards (Credit / Debit)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                const SizedBox(height: 8),

                _buildPaymentTile(
                  id: 'card',
                  title: 'HDFC Bank Visa Card',
                  subtitle: '•••• •••• •••• 8492',
                  icon: Icons.credit_card_rounded,
                  iconColor: AppColors.primary,
                  trailingWidget: _selectedMethod == 'card'
                      ? SizedBox(
                          width: 70,
                          height: 38,
                          child: TextField(
                            controller: _cardCvvController,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'CVV',
                              counterText: '',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 16),

                // Net Banking Section (Screen 55)
                const Text('Net Banking & More', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                const SizedBox(height: 8),

                _buildPaymentTile(
                  id: 'netbanking',
                  title: 'Net Banking',
                  subtitle: 'HDFC, ICICI, SBI, Axis, Kotak',
                  icon: Icons.account_balance_rounded,
                  iconColor: const Color(0xFF059669),
                ),

                // Cash on Delivery
                _buildPaymentTile(
                  id: 'cod',
                  title: 'Cash on Delivery (COD)',
                  subtitle: 'Pay with cash or UPI upon delivery',
                  icon: Icons.local_shipping_outlined,
                  iconColor: AppColors.accent,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Bottom Pay CTA
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _processPayment,
                child: Text(
                  'Pay \$${widget.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTile({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    Widget? trailingWidget,
  }) {
    final isSelected = _selectedMethod == id;

    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.04) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (trailingWidget != null) ...[
              trailingWidget,
              const SizedBox(width: 8),
            ],
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(String num, String title, {required bool isActive, required bool isDone}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isDone || isActive ? AppColors.primary : AppColors.border,
          child: isDone
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : Text(num, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
            color: isActive || isDone ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
