import 'dart:ffi';

import 'package:flutter/material.dart';

import 'product.dart';

class CartModel with ChangeNotifier {
  final List<Product> _products = [];
  final List<int> _quantityList = List.filled(1, 0, growable: true);
  double _totalValue = 0.0;

  List<Product> get products => _products;
  List<int> get quantityList => _quantityList;
  double get totalValue => _totalValue;

  void toogleIsInCart(Product product) {
    if (products.contains(product)) {
      _totalValue -= product.price *
          _quantityList[
              products.indexWhere((produto) => produto.id == product.id)];
      _quantityList
          .removeAt(products.indexWhere((produto) => produto.id == product.id));
      _products.remove(product);
    } else {
      _products.add(product);
      _quantityList.insert(
          products.indexWhere((produto) => produto.id == product.id), 1);
      _totalValue += product.price *
          _quantityList[
              products.indexWhere((produto) => produto.id == product.id)];
    }
    notifyListeners();
  }

  void updateTotalValue(int position, int value) {
    _quantityList[position] = value;
    _totalValue = 0;
    for (int i = 0; i < products.length; i++) {
      _totalValue += products[i].price * quantityList[i];
    }
    notifyListeners();
  }
}
