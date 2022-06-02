import 'package:f6_ecommerce/model/cart_model.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'product_cart_item.dart';

class DisplayProductsArea extends StatefulWidget {
  @override
  State<DisplayProductsArea> createState() => _DisplayProductsAreaState();
}

class _DisplayProductsAreaState extends State<DisplayProductsArea> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    print(cart.products.length);
    return ListView.builder(
        itemCount: cart.products.length,
        itemBuilder: ((context, index) {
          return ListTile(leading: ProductInCart(cart.products[index]));
        }));
  }
}
