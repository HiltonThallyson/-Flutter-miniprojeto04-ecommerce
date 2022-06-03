import 'package:f6_ecommerce/model/cart_model.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayTotal extends StatefulWidget {
  @override
  State<DisplayTotal> createState() => _DisplayTotalState();
}

class _DisplayTotalState extends State<DisplayTotal> {
  @override
  Widget build(BuildContext context) {
    var total = context.select<CartModel, num>(
      (cart) => cart.totalValue,
    );
    return Container(
      child: Text(total.toStringAsFixed(2)),
    );
  }
}
