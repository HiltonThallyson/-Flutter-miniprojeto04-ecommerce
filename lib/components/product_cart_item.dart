import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/product.dart';

class ProductInCart extends StatefulWidget {
  Product product;

  ProductInCart(this.product);

  @override
  State<ProductInCart> createState() => _ProductInCartState();
}

class _ProductInCartState extends State<ProductInCart> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.product.title);
  }
}
