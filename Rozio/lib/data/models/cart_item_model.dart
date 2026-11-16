import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  final String selectedColor;
  final String selectedEdition;
  int quantity;

  CartItemModel({
    required this.product,
    required this.selectedColor,
    required this.selectedEdition,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}
