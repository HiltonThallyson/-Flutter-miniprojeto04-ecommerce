import 'package:flutter/material.dart';

import 'product.dart';

class CartItem {
  String id;
  String title;
  int quantity;
  double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class CartModel with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addOrRemoveItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.removeWhere((cartItemId, value) => cartItemId == productId);
      notifyListeners();
    } else {
      _items[productId] =
          CartItem(id: productId, title: title, quantity: 1, price: price);
      notifyListeners();
    }
  }
}
