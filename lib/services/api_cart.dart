import 'package:flutter/material.dart';
import 'package:sticky_flutter_shop/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalPrice => _items.values.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(int productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity += 1;
    } else {
      _items[productId] = CartItem(
        id: productId,
        title: title,
        price: price,
      );
    }
    notifyListeners();
  }

  void removeItem(int productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity -= 1;
    } else {
      _items[productId] = CartItem(
        id: productId,
        title: title,
        price: price,
      );
    }
    notifyListeners();
  }

  void removeAllItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
