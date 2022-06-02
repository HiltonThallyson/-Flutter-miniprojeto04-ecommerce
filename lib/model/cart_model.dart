import 'package:flutter/material.dart';

import 'product.dart';

class CartModel with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void toogleIsInCart(Product product) {
    if (products.contains(product)) {
      products.remove(product);
    } else {
      products.add(product);
    }
    notifyListeners();
  }
}
