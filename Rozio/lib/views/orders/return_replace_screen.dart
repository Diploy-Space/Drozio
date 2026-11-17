import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ReturnReplaceScreen extends StatefulWidget {
  final String orderId;

  const ReturnReplaceScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<ReturnReplaceScreen> createState() => _ReturnReplaceScreenState();
}

class _ReturnReplaceScreenState extends State<ReturnReplaceScreen> {
  int _actionType = 0; // 0: Refund, 1: Replacement
  int _selectedReason = 0;
  bool _isSubmitted = false;

  final List<String> _reasons = [
    'Damaged during transit',
    'Received wrong item or variant',
    'Product quality not as expected',
    'Defective or not functioning',
    'Size did not fit well',
  ];

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      // Screen 69: Return Requested State
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Return status', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 28),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Return request received', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF10B981))),
                          SizedBox(height: 2),
                          Text('Doorstep pickup scheduled for tomorrow by 4 PM', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text('Return Timeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 16),
              _buildTimelineStep('Return Requested', 'Today, 10:30 AM', isDone: true, isCurrent: false),
              _buildTimelineStep('Doorstep Pickup', 'Tomorrow by 4:00 PM', isDone: false, isCurrent: true),
              _buildTimelineStep('Quality Verification', 'Expected within 24h of pickup', isDone: false, isCurrent: false),
              _buildTimelineStep('Refund Processed', 'Instant to original payment method', isDone: false, isCurrent: false),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Orders', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Screen 68: Return or Replace Request Form
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
          'Return or replace',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What would you prefer?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _actionType = 0),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _actionType == 0 ? AppColors.primary.withValues(alpha: 0.08) : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _actionType == 0 ? AppColors.primary : AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Refund', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                          SizedBox(height: 2),
                          Text('Direct to bank / UPI', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _actionType = 1),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _actionType == 1 ? AppColors.primary.withValues(alpha: 0.08) : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _actionType == 1 ? AppColors.primary : AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Replacement', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                          SizedBox(height: 2),
                          Text('Same item exchange', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Reason for return', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 10),

            ..._reasons.asMap().entries.map((entry) {
              final idx = entry.key;
              final r = entry.value;
              final isSelected = _selectedReason == idx;

              return InkWell(
                onTap: () => setState(() => _selectedReason = idx),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? AppColors.primary : AppColors.textMuted),
                      const SizedBox(width: 12),
                      Text(r, style: TextStyle(fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, fontSize: 13, color: isSelected ? AppColors.primary : AppColors.textPrimary)),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),

            // Pickup Address note
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Pickup Address', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                  SizedBox(height: 2),
                  Text('Flat 402, Lotus Grand, Link Road, Andheri West, Mumbai 400053', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => setState(() => _isSubmitted = true),
                child: const Text('Submit Return Request', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(String title, String time, {required bool isDone, required bool isCurrent}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor: isDone
                  ? const Color(0xFF10B981)
                  : (isCurrent ? AppColors.primary : AppColors.border),
            ),
            Container(width: 2, height: 36, color: isDone ? const Color(0xFF10B981) : AppColors.border),
          ],
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: isCurrent || isDone ? FontWeight.w800 : FontWeight.w500, fontSize: 13)),
            const SizedBox(height: 2),
            Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ],
        ),
      ],
    );
  }
}
