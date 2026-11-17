import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class FilterState {
  RangeValues priceRange;
  double minRating;
  bool discountedOnly;
  bool inStockOnly;
  bool verifiedOnly;

  FilterState({
    this.priceRange = const RangeValues(20, 300),
    this.minRating = 0.0,
    this.discountedOnly = false,
    this.inStockOnly = true,
    this.verifiedOnly = false,
  });

  int get activeFilterCount {
    int count = 0;
    if (priceRange.start > 20 || priceRange.end < 300) count++;
    if (minRating > 0) count++;
    if (discountedOnly) count++;
    if (verifiedOnly) count++;
    return count;
  }
}

class FiltersBottomSheet extends StatefulWidget {
  final FilterState initialState;
  final ValueChanged<FilterState> onApply;

  const FiltersBottomSheet({
    super.key,
    required this.initialState,
    required this.onApply,
  });

  static Future<FilterState?> show(BuildContext context, FilterState current) {
    return showModalBottomSheet<FilterState>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => FiltersBottomSheet(
        initialState: current,
        onApply: (state) => Navigator.pop(context, state),
      ),
    );
  }

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  late RangeValues _range;
  late double _rating;
  late bool _discounted;
  late bool _inStock;
  late bool _verified;

  @override
  void initState() {
    super.initState();
    _range = widget.initialState.priceRange;
    _rating = widget.initialState.minRating;
    _discounted = widget.initialState.discountedOnly;
    _inStock = widget.initialState.inStockOnly;
    _verified = widget.initialState.verifiedOnly;
  }

  void _reset() {
    setState(() {
      _range = const RangeValues(20, 300);
      _rating = 0.0;
      _discounted = false;
      _inStock = true;
      _verified = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeCount = (_range.start > 20 || _range.end < 300 ? 1 : 0) +
        (_rating > 0 ? 1 : 0) +
        (_discounted ? 1 : 0) +
        (_verified ? 1 : 0);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        activeCount > 0 ? '$activeCount filters active' : 'Filter your search results',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _reset,
                    child: const Text(
                      'Clear all',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),

              // Price Section
              const Text(
                'Price Range',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${_range.start.toInt()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const Text('to', style: TextStyle(color: AppColors.textSecondary)),
                  Text(
                    '\$${_range.end.toInt()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              RangeSlider(
                values: _range,
                min: 10,
                max: 500,
                divisions: 49,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.border,
                onChanged: (values) => setState(() => _range = values),
              ),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Under \$50'),
                    selected: _range.end <= 50,
                    onSelected: (sel) => setState(() => _range = const RangeValues(10, 50)),
                  ),
                  ChoiceChip(
                    label: const Text('\$50 to \$200'),
                    selected: _range.start == 50 && _range.end == 200,
                    onSelected: (sel) => setState(() => _range = const RangeValues(50, 200)),
                  ),
                  ChoiceChip(
                    label: const Text('Over \$200'),
                    selected: _range.start >= 200,
                    onSelected: (sel) => setState(() => _range = const RangeValues(200, 500)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Customer Rating
              const Text(
                'Customer Rating',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('Any'),
                    selected: _rating == 0.0,
                    onSelected: (sel) => setState(() => _rating = 0.0),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('4.0 '),
                        Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                        Text(' & up'),
                      ],
                    ),
                    selected: _rating == 4.0,
                    onSelected: (sel) => setState(() => _rating = 4.0),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('4.5 '),
                        Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                        Text(' & up'),
                      ],
                    ),
                    selected: _rating == 4.5,
                    onSelected: (sel) => setState(() => _rating = 4.5),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Toggles
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Discounted only', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: const Text('Show items with active price drops', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                value: _discounted,
                activeThumbColor: AppColors.primary,
                onChanged: (val) => setState(() => _discounted = val),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('In stock only', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: const Text('Exclude sold-out and notify-only items', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                value: _inStock,
                activeThumbColor: AppColors.primary,
                onChanged: (val) => setState(() => _inStock = val),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Verified stores only', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: const Text('Only show products from Rozio verified merchants', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                value: _verified,
                activeThumbColor: AppColors.primary,
                onChanged: (val) => setState(() => _verified = val),
              ),
              const SizedBox(height: 24),

              // Apply Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    widget.onApply(FilterState(
                      priceRange: _range,
                      minRating: _rating,
                      discountedOnly: _discounted,
                      inStockOnly: _inStock,
                      verifiedOnly: _verified,
                    ));
                  },
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
