import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:provider/provider.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double? price, {double? discount, String? discountType}) {
    if (price == null) return '';

    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }

    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      final config = splashProvider.configModel;
      bool singleCurrency = config?.currencyModel == 'single_currency';
      bool inRight = config?.currencySymbolPosition == 'right';
      String symbol = splashProvider.myCurrency?.symbol ?? '\$';
      int decimalPoint = config?.decimalPointSettings ?? 1;

      double myRate = splashProvider.myCurrency?.exchangeRate ?? 1.0;
      double usdRate = splashProvider.usdCurrency?.exchangeRate ?? 1.0;
      if (usdRate == 0) usdRate = 1.0;

      double finalPrice = singleCurrency ? price : (price * myRate * (1 / usdRate));
      String formattedPrice = finalPrice
          .toStringAsFixed(decimalPoint)
          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

      return inRight ? '$formattedPrice$symbol' : '$symbol$formattedPrice';
    } catch (_) {
      return price.toStringAsFixed(2);
    }
  }

  static double? convertWithDiscount(BuildContext? context, double? price, double? discount, String? discountType) {
    if (price == null) return null;
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount' || type == 'flat') {
      calculatedAmount = discount * quantity;
    } else if (type == 'percent' || type == 'percentage') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, double? price, double? discount, String? discountType) {
    int decimalPoint = 1;
    try {
      decimalPoint = Provider.of<SplashController>(context, listen: false).configModel?.decimalPointSettings ?? 1;
    } catch (_) {}

    return '-${(discountType == 'percent' || discountType == 'percentage')
        ? '${discount?.toStringAsFixed(decimalPoint) ?? '0'} %'
        : convertPrice(context, discount)}';
  }

  static String getUnitCurrency(BuildContext context, double? price) {
    if (price == null) return '';
    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      final config = splashProvider.configModel;
      bool singleCurrency = config?.currencyModel == 'single_currency';
      bool inRight = config?.currencySymbolPosition == 'right';
      String symbol = splashProvider.myCurrency?.symbol ?? '\$';
      int decimalPoint = config?.decimalPointSettings ?? 1;

      double finalPrice = singleCurrency ? price : price;
      String formattedPrice = finalPrice
          .toStringAsFixed(decimalPoint)
          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

      return inRight ? '$formattedPrice$symbol' : '$symbol$formattedPrice';
    } catch (_) {
      return price.toStringAsFixed(2);
    }
  }

  static String convertPriceWithoutSymbol(BuildContext context, double? price, {double? discount, String? discountType}) {
    if (price == null) return '0.0';

    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }

    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      final config = splashProvider.configModel;
      bool singleCurrency = config?.currencyModel == 'single_currency';
      int decimalPoint = config?.decimalPointSettings ?? 1;

      double myRate = splashProvider.myCurrency?.exchangeRate ?? 1.0;
      double usdRate = splashProvider.usdCurrency?.exchangeRate ?? 1.0;
      if (usdRate == 0) usdRate = 1.0;

      double finalPrice = singleCurrency ? price : (price * myRate * (1 / usdRate));
      return finalPrice.toStringAsFixed(decimalPoint);
    } catch (_) {
      return price.toStringAsFixed(2);
    }
  }

  static double toLocalDouble(BuildContext context, double price) {
    try {
      final splash = Provider.of<SplashController>(context, listen: false);
      if (splash.configModel?.currencyModel == 'single_currency') return price;
      double myRate = splash.myCurrency?.exchangeRate ?? 1.0;
      double usdRate = splash.usdCurrency?.exchangeRate ?? 1.0;
      if (usdRate == 0) usdRate = 1.0;
      return price * myRate / usdRate;
    } catch (_) {
      return price;
    }
  }

  static String longToShortPrice(double amount, {bool withDecimalPoint = true}) {
    int decimalPoint = withDecimalPoint ? 2 : 0;

    if (amount.abs() >= 1e12) {
      return '${(amount / 1e12).toStringAsFixed(decimalPoint)}T';
    } else if (amount.abs() >= 1e9) {
      return '${(amount / 1e9).toStringAsFixed(decimalPoint)}B';
    } else if (amount.abs() >= 1e6) {
      return '${(amount / 1e6).toStringAsFixed(decimalPoint)}M';
    } else if (amount.abs() >= 1e3) {
      return '${(amount / 1e3).toStringAsFixed(decimalPoint)}K';
    } else {
      return amount.toStringAsFixed(decimalPoint);
    }
  }
}
