import 'package:f6_ecommerce/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../model/product_list.dart';

class ProductInCart extends StatefulWidget {
  Product product;
  int productPosition;
  ProductInCart(this.product, this.productPosition);

  @override
  State<ProductInCart> createState() => _ProductInCartState();
}

class _ProductInCartState extends State<ProductInCart> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    var provider = context.read<ProductList>();
    int quantity = cart.quantityList[widget.productPosition];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            alignment: Alignment.center,
            width: 100,
            margin: EdgeInsets.all(15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Wrap(children: [
              Text(
                widget.product.price.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ])),
        Container(
          width: 80,
          child: Wrap(children: [
            Text(widget.product.title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ]),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: QuantityInput(
            readOnly: true,
            maxValue: 100,
            inputWidth: 50,
            buttonColor: Theme.of(context).colorScheme.secondary,
            iconColor: Colors.black,
            value: quantity,
            onChanged: (value) => setState(() {
              quantity = int.parse(value.replaceAll(',', ''));
              cart.quantityList[widget.productPosition] = quantity;
              cart.updateTotalValue(widget.productPosition, quantity);
            }),
          ),
        )
      ],
    );
  }
}
