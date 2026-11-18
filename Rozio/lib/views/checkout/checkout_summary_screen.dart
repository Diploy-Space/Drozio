import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/cart_provider.dart';
import 'checkout_payment_screen.dart';
import 'coupons_bottom_sheet.dart';

class CheckoutSummaryScreen extends StatefulWidget {
  final Map<String, String> selectedAddress;

  const CheckoutSummaryScreen({
    super.key,
    required this.selectedAddress,
  });

  @override
  State<CheckoutSummaryScreen> createState() => _CheckoutSummaryScreenState();
}

class _CheckoutSummaryScreenState extends State<CheckoutSummaryScreen> {
  Map<String, dynamic>? _appliedCoupon = {
    'code': 'REEL10',
    'discountPercent': 10,
    'flatDiscount': 0,
    'title': '10% OFF · REEL10 Applied',
  };

  bool _isExpressDelivery = false;
  bool _wantGstInvoice = false;
  final _gstinController = TextEditingController(text: '27AABCU9603R1ZM');
  final _businessNameController = TextEditingController(text: 'Diploy Space Technologies');

  @override
  void dispose() {
    _gstinController.dispose();
    _businessNameController.dispose();
    super.dispose();
  }

  void _changeCoupon() async {
    final res = await CouponsBottomSheet.show(context);
    if (res != null) {
      setState(() => _appliedCoupon = res);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    double discount = 0;
    if (_appliedCoupon != null) {
      if (_appliedCoupon!['flatDiscount'] > 0) {
        discount = (_appliedCoupon!['flatDiscount'] as num).toDouble();
      } else if (_appliedCoupon!['discountPercent'] > 0) {
        discount = cart.subtotal * ((_appliedCoupon!['discountPercent'] as num) / 100);
      }
    }

    final deliveryFee = _isExpressDelivery ? 4.0 : 0.0;
    const platformFee = 1.0;
    final totalPayable = (cart.subtotal - discount + deliveryFee + platformFee).clamp(0.0, double.infinity);

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
          'Order summary',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          // Step Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                _buildStepIndicator('1', 'Address', isDone: true, isActive: false),
                Expanded(child: Container(height: 2, color: AppColors.primary)),
                _buildStepIndicator('2', 'Summary', isDone: false, isActive: true),
                Expanded(child: Container(height: 2, color: AppColors.border)),
                _buildStepIndicator('3', 'Payment', isDone: false, isActive: false),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              children: [
                // Delivery Address Mini Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: AppColors.primary, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Deliver to: ${widget.selectedAddress['name']}',
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Text('Change', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 12)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.selectedAddress['address']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Order Items Summary
                const Text('Items in your bag', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                const SizedBox(height: 10),
                ...cart.items.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(item.product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.product.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                            const SizedBox(height: 2),
                            Text('Qty: ${item.quantity} · ${item.selectedColor}, ${item.selectedEdition}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      Text('\$${(item.product.price * item.quantity).toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.textPrimary)),
                    ],
                  ),
                )),
                const SizedBox(height: 16),

                // Delivery Speed Options
                const Text('Delivery speed', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isExpressDelivery = false),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: !_isExpressDelivery ? AppColors.primary.withValues(alpha: 0.05) : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: !_isExpressDelivery ? AppColors.primary : AppColors.border),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Standard', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                              SizedBox(height: 2),
                              Text('FREE · 2 Days', style: TextStyle(fontSize: 11, color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isExpressDelivery = true),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _isExpressDelivery ? AppColors.primary.withValues(alpha: 0.05) : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: _isExpressDelivery ? AppColors.primary : AppColors.border),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('🚀 Express', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                              SizedBox(height: 2),
                              Text('+\$4 · Tomorrow 2 PM', style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Coupon Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _appliedCoupon != null ? const Color(0xFF10B981).withValues(alpha: 0.08) : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _appliedCoupon != null ? const Color(0xFF10B981) : AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.confirmation_num_outlined, color: Color(0xFF10B981), size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _appliedCoupon != null ? '${_appliedCoupon!['code']} Applied' : 'Apply coupon',
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF10B981)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _appliedCoupon != null ? 'Saving \$${discount.toInt()}' : 'Check available discount codes',
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: _changeCoupon,
                        child: Text(
                          _appliedCoupon != null ? 'Change' : 'Apply',
                          style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // GST / Business Invoice Toggle (Screen 50)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Use GSTIN for business invoice', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  subtitle: const Text('Claim input tax credit on this purchase', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  value: _wantGstInvoice,
                  activeThumbColor: AppColors.primary,
                  onChanged: (val) => setState(() => _wantGstInvoice = val),
                ),
                if (_wantGstInvoice) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GSTIN: ${_gstinController.text}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                        const SizedBox(height: 2),
                        Text('Business: ${_businessNameController.text}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Bill Details Breakdown
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bill Details', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                      const SizedBox(height: 12),
                      _buildBillRow('Item Total', '\$${cart.subtotal.toStringAsFixed(0)}'),
                      if (discount > 0)
                        _buildBillRow('Coupon Discount (${_appliedCoupon!['code']})', '-\$${discount.toStringAsFixed(0)}', isGreen: true),
                      _buildBillRow('Delivery Fee', _isExpressDelivery ? '\$4' : 'FREE', isGreen: !_isExpressDelivery),
                      _buildBillRow('Platform Fee', '\$1'),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Payable', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                          Text('\$${totalPayable.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: AppColors.primary)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // Bottom Continue to Payment CTA
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Total Amount', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    Text('\$${totalPayable.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CheckoutPaymentScreen(
                              totalAmount: totalPayable,
                              address: widget.selectedAddress,
                            ),
                          ),
                        );
                      },
                      child: const Text('Proceed to Payment', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isGreen ? const Color(0xFF10B981) : AppColors.textPrimary,
            ),
          ),
        ],
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
