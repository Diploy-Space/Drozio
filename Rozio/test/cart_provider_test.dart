import 'package:flutter_test/flutter_test.dart';
import 'package:rozio/data/models/product_model.dart';
import 'package:rozio/providers/cart_provider.dart';

void main() {
  group('CartProvider Tests', () {
    late CartProvider cartProvider;
    const testProduct = ProductModel(
      id: 'test_prod_1',
      title: 'Wireless Earbuds',
      storeName: 'Audio Lab',
      price: 50.0,
      originalPrice: 80.0,
      imageUrl: 'https://example.com/image.jpg',
      availableColors: ['White', 'Black'],
    );

    setUp(() {
      cartProvider = CartProvider(initialItems: []);
    });

    test('Initial cart is empty', () {
      expect(cartProvider.items.isEmpty, isTrue);
      expect(cartProvider.itemCount, 0);
      expect(cartProvider.subtotal, 0.0);
    });

    test('Adding single item updates itemCount and subtotal', () {
      cartProvider.addItem(
        product: testProduct,
        selectedColor: 'Black',
        selectedEdition: 'Standard',
        quantity: 2,
      );

      expect(cartProvider.items.length, 1);
      expect(cartProvider.itemCount, 2);
      expect(cartProvider.subtotal, 100.0);
    });

    test('Adding identical item merges quantity', () {
      cartProvider.addItem(
        product: testProduct,
        selectedColor: 'Black',
        selectedEdition: 'Standard',
        quantity: 1,
      );
      cartProvider.addItem(
        product: testProduct,
        selectedColor: 'Black',
        selectedEdition: 'Standard',
        quantity: 2,
      );

      expect(cartProvider.items.length, 1);
      expect(cartProvider.items.first.quantity, 3);
      expect(cartProvider.itemCount, 3);
      expect(cartProvider.subtotal, 150.0);
    });

    test('Updating quantity changes subtotal', () {
      cartProvider.addItem(
        product: testProduct,
        selectedColor: 'Black',
        selectedEdition: 'Standard',
        quantity: 1,
      );

      cartProvider.updateQuantity(0, 5);
      expect(cartProvider.items.first.quantity, 5);
      expect(cartProvider.subtotal, 250.0);

      // Decrementing to 0 removes the item
      cartProvider.updateQuantity(0, 0);
      expect(cartProvider.items.isEmpty, isTrue);
    });

    test('Removing item updates cart correctly', () {
      cartProvider.addItem(
        product: testProduct,
        selectedColor: 'Black',
        selectedEdition: 'Standard',
        quantity: 2,
      );
      expect(cartProvider.items.length, 1);

      cartProvider.removeItem(0);
      expect(cartProvider.items.isEmpty, isTrue);
      expect(cartProvider.itemCount, 0);
    });

    test('Clearing cart removes all items', () {
      cartProvider.addItem(
        product: testProduct,
        selectedColor: 'Black',
        selectedEdition: 'Standard',
        quantity: 2,
      );
      cartProvider.clearCart();
      expect(cartProvider.items.isEmpty, isTrue);
      expect(cartProvider.itemCount, 0);
    });
  });
}
