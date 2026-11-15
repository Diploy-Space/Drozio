import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/features/splash/controllers/splash_controller.dart';

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
      final decimal = config?.decimalPointSettings ?? 1;
      final symbol = splashProvider.myCurrency?.symbol ?? '\$';

      double myRate = splashProvider.myCurrency?.exchangeRate ?? 1.0;
      double usdRate = splashProvider.usdCurrency?.exchangeRate ?? 1.0;
      if (usdRate == 0) usdRate = 1.0;

      double finalPrice = singleCurrency ? price : (price * myRate * (1 / usdRate));

      final mod = pow(10.0, decimal);
      finalPrice = (finalPrice * mod).truncateToDouble() / mod;

      final formatted = finalPrice.toStringAsFixed(decimal).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );

      return inRight ? '$formatted$symbol' : '$symbol$formatted';
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

  static String reverseConvertPriceWithoutSymbol(BuildContext context, double? localPrice, {double? discount, String? discountType, bool removeDecimalPoint = false}) {
    if (localPrice == null) return '0.00';

    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      bool singleCurrency = splashProvider.configModel?.currencyModel == 'single_currency';

      if (!singleCurrency && splashProvider.myCurrency != null && splashProvider.usdCurrency != null) {
        double myRate = splashProvider.myCurrency?.exchangeRate ?? 1.0;
        double usdRate = splashProvider.usdCurrency?.exchangeRate ?? 1.0;
        if (myRate != 0) {
          localPrice = localPrice / myRate * usdRate;
        }
      }

      if (discount != null && discountType != null) {
        if (discountType == 'amount' || discountType == 'flat') {
          localPrice = localPrice + discount;
        } else if (discountType == 'percent' || discountType == 'percentage') {
          if (discount < 100) {
            localPrice = localPrice / (1 - (discount / 100));
          }
        }
      }

      return localPrice.toString();
    } catch (_) {
      return localPrice.toString();
    }
  }

  static double systemCurrencyToDefaultCurrency(double price, BuildContext context) {
    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      bool singleCurrency = splashProvider.configModel?.currencyModel == 'single_currency';
      if (singleCurrency) {
        return price;
      } else {
        double myRate = splashProvider.myCurrency?.exchangeRate ?? 1.0;
        if (myRate == 0) myRate = 1.0;
        return price / myRate;
      }
    } catch (_) {
      return price;
    }
  }

  static double convertAmount(double amount, BuildContext context) {
    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      final config = splashProvider.configModel;
      int decimal = config?.decimalPointSettings ?? 1;
      double myRate = splashProvider.myCurrency?.exchangeRate ?? 1.0;
      double usdRate = splashProvider.usdCurrency?.exchangeRate ?? 1.0;
      if (usdRate == 0) usdRate = 1.0;

      return double.parse((amount * myRate * (1 / usdRate)).toStringAsFixed(decimal));
    } catch (_) {
      return amount;
    }
  }

  static String percentageCalculation(BuildContext context, double? price, double? discount, String? discountType) {
    return '-${(discountType == 'percent' || discountType == 'percentage') ? '$discount %' : convertPrice(context, discount)}';
  }

  static String discountCalculationWithOutSymbol(BuildContext context, double price, double discount, String? discountType, {bool convertCurrency = true}) {
    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);

      if (discountType == 'percent') {
        discount = ((discount / 100) * price);
      }

      if (discountType == 'percent' && convertCurrency) {
        double myRate = splashProvider.myCurrency?.exchangeRate ?? 1.0;
        double usdRate = splashProvider.usdCurrency?.exchangeRate ?? 1.0;
        if (usdRate == 0) usdRate = 1.0;
        discount = discount * myRate * (1 / usdRate);
      }

      return discount.toStringAsFixed(2);
    } catch (_) {
      return discount.toStringAsFixed(2);
    }
  }

  static String discountCalculation(BuildContext context, double price, double discount, String? discountType) {
    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      if (discountType == 'percent') {
        discount = ((discount / 100) * price);
      }
      final symbol = splashProvider.myCurrency?.symbol ?? '\$';
      return '$symbol ${discount.toStringAsFixed(2)}';
    } catch (_) {
      return '\$ ${discount.toStringAsFixed(2)}';
    }
  }

  static String getUnitCurrency(BuildContext context, double? price) {
    if (price == null) return '';
    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      final config = splashProvider.configModel;
      bool inRight = config?.currencySymbolPosition == 'right';
      final symbol = splashProvider.myCurrency?.symbol ?? '\$';
      int decimal = config?.decimalPointSettings ?? 1;

      String formattedPrice = price
          .toStringAsFixed(decimal)
          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

      return inRight ? '$formattedPrice$symbol' : '$symbol$formattedPrice';
    } catch (_) {
      return price.toStringAsFixed(2);
    }
  }

  static String showCurrencyCode(BuildContext context, String amount) {
    try {
      final splashProvider = Provider.of<SplashController>(context, listen: false);
      bool inRight = splashProvider.configModel?.currencySymbolPosition == 'right';
      String symbol = splashProvider.myCurrency?.symbol ?? '\$';

      return inRight ? '$amount$symbol' : '$symbol$amount';
    } catch (_) {
      return '\$$amount';
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
