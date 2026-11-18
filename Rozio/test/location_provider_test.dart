import 'package:flutter_test/flutter_test.dart';
import 'package:rozio/data/models/language_model.dart';
import 'package:rozio/providers/location_provider.dart';

void main() {
  group('LocationProvider Tests', () {
    late LocationProvider locationProvider;

    setUp(() {
      locationProvider = LocationProvider();
    });

    test('Initial location defaults to Mumbai', () {
      expect(locationProvider.pincode, '400053');
      expect(locationProvider.city, contains('Mumbai'));
      expect(locationProvider.isLocationSet, isTrue);
    });

    test('Updating pincode and city updates state correctly', () {
      locationProvider.updatePincode('560001', city: 'Bangalore', state: 'Karnataka');
      expect(locationProvider.pincode, '560001');
      expect(locationProvider.city, 'Bangalore');
      expect(locationProvider.state, 'Karnataka');
    });

    test('Setting language updates selectedLanguage', () {
      final hindi = LanguageModel.supportedLanguages.firstWhere(
        (l) => l.id == 'hi',
        orElse: () => LanguageModel.supportedLanguages.last,
      );
      locationProvider.setLanguage(hindi);
      expect(locationProvider.selectedLanguage.id, hindi.id);
    });
  });
}
