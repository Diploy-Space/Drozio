import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/location_provider.dart';

class ChangeAddressSheet extends StatefulWidget {
  const ChangeAddressSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const ChangeAddressSheet(),
    );
  }

  @override
  State<ChangeAddressSheet> createState() => _ChangeAddressSheetState();
}

class _ChangeAddressSheetState extends State<ChangeAddressSheet> {
  final List<Map<String, String>> _savedAddresses = [
    {
      'title': 'Home',
      'name': 'Rahul Sharma',
      'address': 'Flat 402, Lotus Grand, Link Road, Andheri West, Mumbai 400053',
      'pincode': '400053',
      'city': 'Mumbai',
      'eta': 'Tomorrow, by 2 PM',
    },
    {
      'title': 'Office',
      'name': 'Rahul Sharma',
      'address': 'WeWork Enam Sambhav, BKC, Bandra East, Mumbai 400051',
      'pincode': '400051',
      'city': 'Mumbai',
      'eta': 'Thursday, Oct 29',
    },
  ];

  int _selectedAddressIndex = 0;

  @override
  Widget build(BuildContext context) {
    final location = context.read<LocationProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Choose delivery address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),

            ..._savedAddresses.asMap().entries.map((entry) {
              final index = entry.key;
              final addr = entry.value;
              final isSelected = _selectedAddressIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedAddressIndex = index);
                  location.setPincode(addr['pincode']!);
                  location.setCity(addr['city']!);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.05) : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          addr['title'] == 'Home' ? Icons.home_rounded : Icons.work_rounded,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(addr['title']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    addr['eta']!,
                                    style: const TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(addr['name']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                            const SizedBox(height: 2),
                            Text(addr['address']!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3)),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
