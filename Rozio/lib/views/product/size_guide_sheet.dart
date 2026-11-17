import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SizeGuideSheet extends StatelessWidget {
  const SizeGuideSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const SizeGuideSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizes = [
      {'size': 'S', 'chest': '38 in (96 cm)', 'length': '27 in (69 cm)', 'sleeve': '33 in'},
      {'size': 'M', 'chest': '40 in (102 cm)', 'length': '28 in (71 cm)', 'sleeve': '34 in'},
      {'size': 'L', 'chest': '42 in (107 cm)', 'length': '29 in (74 cm)', 'sleeve': '35 in'},
      {'size': 'XL', 'chest': '44 in (112 cm)', 'length': '30 in (76 cm)', 'sleeve': '36 in'},
    ];

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
                  'Size guide',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'How to measure',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            const Text(
              'Measure around the fullest part of your chest, keeping the tape horizontal under your arms.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
            ),
            const SizedBox(height: 16),

            // Table
            Table(
              border: TableBorder.all(color: AppColors.border, borderRadius: BorderRadius.circular(8)),
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: AppColors.surfaceLight),
                  children: const [
                    Padding(padding: EdgeInsets.all(8), child: Text('Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    Padding(padding: EdgeInsets.all(8), child: Text('Chest', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    Padding(padding: EdgeInsets.all(8), child: Text('Length', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    Padding(padding: EdgeInsets.all(8), child: Text('Sleeve', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
                ...sizes.map((s) => TableRow(
                  children: [
                    Padding(padding: const EdgeInsets.all(8), child: Text(s['size']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                    Padding(padding: const EdgeInsets.all(8), child: Text(s['chest']!, style: const TextStyle(fontSize: 12))),
                    Padding(padding: const EdgeInsets.all(8), child: Text(s['length']!, style: const TextStyle(fontSize: 12))),
                    Padding(padding: const EdgeInsets.all(8), child: Text(s['sleeve']!, style: const TextStyle(fontSize: 12))),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
