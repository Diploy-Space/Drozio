import 'package:flutter/material.dart';
import '../data/models/language_model.dart';

class LocationProvider extends ChangeNotifier {
  LanguageModel _selectedLanguage = LanguageModel.supportedLanguages.first;
  String _pincode = '400053';
  String _city = 'Andheri West, Mumbai';
  String _state = 'Maharashtra';
  final String _deliveryEstimate = 'Delivery in 2 days';
  bool _isLocationSet = true;

  LanguageModel get selectedLanguage => _selectedLanguage;
  String get pincode => _pincode;
  String get city => _city;
  String get state => _state;
  String get deliveryEstimate => _deliveryEstimate;
  bool get isLocationSet => _isLocationSet;

  void setLanguage(LanguageModel language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void updatePincode(String code, {String? city, String? state}) {
    _pincode = code;
    if (city != null) _city = city;
    if (state != null) _state = state;
    _isLocationSet = true;
    notifyListeners();
  }
}
