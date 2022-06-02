import 'package:flutter/material.dart';

import 'product.dart';

class CartModel with ChangeNotifier {
  final List<Product> _products = [];
  final List<int> _quantityList = [];

  List<Product> get products => _products;
  List<int> get quantityList => _quantityList;

  void toogleIsInCart(Product product) {
    if (products.contains(product)) {
      _products.remove(product);
    } else {
      _products.add(product);
    }
    notifyListeners();
  }
}
