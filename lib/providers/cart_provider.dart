import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  int get totalItems => _items.length;

  double get totalPrice {
    return _items.values
        .map((item) => item.totalPrice)
        .fold(0.0, (prev, price) => prev + price);
  }

  void addToCart(int productId, int quantity, {Product? product}) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity += quantity;
    } else {
      if (product != null) {
        _items[productId] = CartItem(product: product, quantity: quantity);
      }
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
