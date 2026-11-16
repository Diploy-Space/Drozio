import 'package:flutter/material.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem({
    required ProductModel product,
    required String selectedColor,
    required String selectedEdition,
    int quantity = 1,
  }) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedColor == selectedColor &&
          item.selectedEdition == selectedEdition,
    );

    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(
        CartItemModel(
          product: product,
          selectedColor: selectedColor,
          selectedEdition: selectedEdition,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _items.length) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
