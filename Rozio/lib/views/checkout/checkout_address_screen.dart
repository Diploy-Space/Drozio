import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'add_address_screen.dart';
import 'checkout_summary_screen.dart';

class CheckoutAddressScreen extends StatefulWidget {
  const CheckoutAddressScreen({super.key});

  @override
  State<CheckoutAddressScreen> createState() => _CheckoutAddressScreenState();
}

class _CheckoutAddressScreenState extends State<CheckoutAddressScreen> {
  int _selectedAddressIndex = 0;

  final List<Map<String, String>> _addresses = [
    {
      'title': 'Home',
      'name': 'Rahul Sharma',
      'phone': '+91 98765 43210',
      'address': 'Flat 402, Lotus Grand, Link Road, Opp. Infiniti Mall, Andheri West, Mumbai, Maharashtra 400053',
      'eta': 'Tomorrow, by 2 PM',
      'isDefault': 'true',
    },
    {
      'title': 'Work / Office',
      'name': 'Rahul Sharma',
      'phone': '+91 98765 43210',
      'address': 'WeWork Enam Sambhav, C-20, G Block, BKC, Bandra East, Mumbai, Maharashtra 400051',
      'eta': 'Thursday, Oct 29',
      'isDefault': 'false',
    },
  ];

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
          'Select delivery address',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          // Step Progress Bar (1: Address, 2: Summary, 3: Payment)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                _buildStepIndicator('1', 'Address', isActive: true, isDone: false),
                Expanded(child: Container(height: 2, color: AppColors.border)),
                _buildStepIndicator('2', 'Summary', isActive: false, isDone: false),
                Expanded(child: Container(height: 2, color: AppColors.border)),
                _buildStepIndicator('3', 'Payment', isActive: false, isDone: false),
              ],
            ),
          ),

          // Addresses List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              children: [
                ..._addresses.asMap().entries.map((entry) {
                  final index = entry.key;
                  final addr = entry.value;
                  final isSelected = _selectedAddressIndex == index;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedAddressIndex = index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withValues(alpha: 0.04) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  addr['title']!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected ? Colors.white : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.bolt_rounded, size: 12, color: Color(0xFF10B981)),
                                    const SizedBox(width: 2),
                                    Text(
                                      addr['eta']!,
                                      style: const TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                                color: isSelected ? AppColors.primary : AppColors.textMuted,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            addr['name']!,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            addr['address']!,
                            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.35),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Phone: ${addr['phone']}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                // Add New Address Button
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    final res = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddAddressScreen()),
                    );
                    if (res != null && res is Map<String, String>) {
                      setState(() {
                        _addresses.insert(0, res);
                        _selectedAddressIndex = 0;
                      });
                    }
                  },
                  icon: const Icon(Icons.add_rounded, color: AppColors.primary),
                  label: const Text(
                    'Add New Address',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Action
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: const BoxDecoration(
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
                onPressed: () {
                  final chosen = _addresses[_selectedAddressIndex];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutSummaryScreen(selectedAddress: chosen),
                    ),
                  );
                },
                child: const Text(
                  'Deliver to this address',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
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
          backgroundColor: isActive || isDone ? AppColors.primary : AppColors.border,
          child: Text(
            num,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
            color: isActive ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
