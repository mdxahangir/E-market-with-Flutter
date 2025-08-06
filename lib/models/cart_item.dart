import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice {
    final discountedPrice = product.price - (product.price * product.discount / 100);
    return discountedPrice * quantity;
  }
}
