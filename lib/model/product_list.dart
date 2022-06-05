import 'dart:convert';
import 'dart:math';

import 'package:f6_ecommerce/data/dummy_data.dart';
import 'package:f6_ecommerce/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _baseUrl = 'ecommerce-miniprojeto04-default-rtdb.firebaseio.com';

  //img https://st.depositphotos.com/1000459/2436/i/950/depositphotos_24366251-stock-photo-soccer-ball.jpg

  List<Product> _items = [];
  bool _showFavoriteOnly = false;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(Uri.https(_baseUrl, '/products.json'),
          body: jsonEncode({
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavorite": product.isFavorite,
          }));
      final id = jsonDecode(response.body)['name'];
      _items.add(Product(
          id: id,
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.https(_baseUrl, '/products.json'));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      List<Product> loadedProducts = [];
      data.forEach((productId, productData) {
        loadedProducts.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final targetUrl = Uri.https(_baseUrl, '/products/${product.id}.json');
      await http.patch(targetUrl,
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
            'price': product.price,
          }));
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final targetUrl = Uri.https(_baseUrl, '/products/${product.id}.json');

      await http.delete(targetUrl);
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}
