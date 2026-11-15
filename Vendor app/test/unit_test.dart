import 'package:flutter_test/flutter_test.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';

void main() {
  group('PriceConverter Tests', () {
    test('longToShortPrice formats numbers correctly', () {
      expect(PriceConverter.longToShortPrice(500), equals('500.00'));
      expect(PriceConverter.longToShortPrice(1500), equals('1.50K'));
      expect(PriceConverter.longToShortPrice(2500000), equals('2.50M'));
      expect(PriceConverter.longToShortPrice(3500000000), equals('3.50B'));
    });

    test('convertWithDiscount returns null on null price', () {
      expect(PriceConverter.convertWithDiscount(null, null, 10, 'flat'), isNull);
    });
  });

  group('DateConverter Tests', () {
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

    test('clockStringToTimeRange formats correctly', () {
      expect(DateConverter.clockStringToTimeRange('10:00', '18:00'), isNotNull);
      expect(DateConverter.clockStringToTimeRange(null, null), isNull);
    });
  });
}
