import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';

void main() {
  group('PriceConverter Tests', () {
    test('calculation calculates flat discount correctly', () {
      final res = PriceConverter.calculation(100.0, 10.0, 'flat', 2);
      expect(res, equals(20.0));
    });

    test('calculation calculates percent discount correctly', () {
      final res = PriceConverter.calculation(100.0, 10.0, 'percent', 2);
      expect(res, equals(20.0));
    });

    test('longToShortPrice formats numbers correctly', () {
      expect(PriceConverter.longToShortPrice(500), equals('500.00'));
      expect(PriceConverter.longToShortPrice(1500), equals('1.50K'));
      expect(PriceConverter.longToShortPrice(2500000), equals('2.50M'));
      expect(PriceConverter.longToShortPrice(3500000000), equals('3.50B'));
    });
  });

  group('DateConverter Tests', () {
    test('formatDuration formats duration correctly', () {
      const dur1 = Duration(days: 2, hours: 3, minutes: 4, seconds: 5);
      expect(DateConverter.formatDuration(dur1), equals('2d 3h 4m'));

      const dur2 = Duration(hours: 3, minutes: 4, seconds: 5);
      expect(DateConverter.formatDuration(dur2), equals('3h 4m 5s'));
    });

    test('countDays handles null safely', () {
      expect(DateConverter.countDays(null), equals(0));
    });

    test('isoStringToLocalDate handles various ISO formats without throwing', () {
      final d1 = DateConverter.isoStringToLocalDate('2024-05-10T12:00:00.000Z');
      expect(d1, isNotNull);

      final d2 = DateConverter.isoStringToLocalDate('2024-05-10 12:00:00');
      expect(d2, isNotNull);

      final d3 = DateConverter.isoStringToLocalDate('invalid_date_string');
      expect(d3, isNotNull);
    });
  });
}
