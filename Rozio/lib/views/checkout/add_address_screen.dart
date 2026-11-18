import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pincodeController = TextEditingController(text: '400053');
  final _cityController = TextEditingController(text: 'Mumbai');
  final _flatController = TextEditingController();
  final _streetController = TextEditingController();
  final _landmarkController = TextEditingController();

  String _addressType = 'Home'; // Home, Work, Other

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
    _flatController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_nameController.text.trim().isEmpty || _flatController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required address fields')),
      );
      return;
    }

    Navigator.pop(context, {
      'title': _addressType,
      'name': _nameController.text.trim(),
      'address': '${_flatController.text.trim()}, ${_streetController.text.trim()}, ${_cityController.text.trim()} ${_pincodeController.text.trim()}',
      'pincode': _pincodeController.text.trim(),
      'city': _cityController.text.trim(),
      'eta': 'Tomorrow, by 2 PM',
    });
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
          'Add new address',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map location teaser / GPS
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.my_location_rounded, color: AppColors.primary, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Using GPS location: Andheri West, Mumbai',
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildTextField('Full Name *', _nameController, 'e.g. Rahul Sharma'),
            const SizedBox(height: 14),
            _buildTextField('Mobile Number *', _phoneController, '10-digit mobile number', keyboardType: TextInputType.phone),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(child: _buildTextField('Pincode *', _pincodeController, '6-digit pincode', keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: _buildTextField('City *', _cityController, 'City name')),
              ],
            ),
            const SizedBox(height: 14),

            _buildTextField('House No., Building Name *', _flatController, 'e.g. Flat 402, Lotus Grand'),
            const SizedBox(height: 14),
            _buildTextField('Road name, Area, Colony', _streetController, 'e.g. Link Road, Opp. Metro Station'),
            const SizedBox(height: 14),
            _buildTextField('Nearby Landmark (Optional)', _landmarkController, 'e.g. Next to Infinity Mall'),
            const SizedBox(height: 20),

            const Text('Save address as', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children: ['Home', 'Work', 'Other'].map((type) {
                final isSelected = _addressType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    selectedColor: AppColors.primary.withValues(alpha: 0.15),
                    onSelected: (sel) => setState(() => _addressType = type),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: _saveAddress,
                child: const Text('Save & Deliver Here', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
