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
      _quantityList
          .removeAt(products.indexWhere((produto) => produto.id == product.id));
    } else {
      _products.add(product);
      _quantityList.insert(
          products.indexWhere((produto) => produto.id == product.id), 1);
    }
    notifyListeners();
  }
}
