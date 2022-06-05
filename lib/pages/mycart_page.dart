import 'package:f6_ecommerce/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quantity_input/quantity_input.dart';

class MyCart extends StatefulWidget {
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    var cartInfo = context.watch<CartModel>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Meu Carrinho'),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 5,
                child: ListView.builder(
                    itemCount: cartInfo.items.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                border: Border.all(
                                    width: 3,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                              ),
                              child: Text(
                                cartInfo.items.values
                                    .elementAt(index)
                                    .price
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Wrap(children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                width: 160,
                                child: Text(cartInfo.items.values
                                    .elementAt(index)
                                    .title
                                    .toString()),
                              ),
                            ]),
                            QuantityInput(
                                inputWidth: 50,
                                maxValue: 100,
                                acceptsNegatives: false,
                                acceptsZero: false,
                                readOnly: true,
                                buttonColor:
                                    Theme.of(context).colorScheme.secondary,
                                value: cartInfo.items.values
                                    .elementAt(index)
                                    .quantity,
                                onChanged: (value) => setState(() => cartInfo
                                    .items.values
                                    .elementAt(index)
                                    .quantity = int.parse(value))),
                          ],
                        ),
                        // child: ListTile(
                        //   leading: Container(
                        //     alignment: Alignment.center,
                        //     height: 80,
                        //     width: 80,
                        //     decoration: BoxDecoration(
                        //       color: Theme.of(context).colorScheme.primary,
                        //       border: Border.all(
                        //           width: 3,
                        //           color: Theme.of(context).colorScheme.primary),
                        //       borderRadius: BorderRadius.all(Radius.circular(3)),
                        //     ),
                        //     child: Text(
                        //       cartInfo.items.values
                        //           .elementAt(index)
                        //           .price
                        //           .toString(),
                        //       style: TextStyle(
                        //           fontSize: 15, fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        //   title: Wrap(children: [
                        //     Text(cartInfo.items.values
                        //         .elementAt(index)
                        //         .title
                        //         .toString()),
                        //   ]),
                        //   trailing: QuantityInput(
                        //       value: quantity,
                        //       onChanged: (value) => setState(() => quantity =
                        //           int.parse(value.replaceAll(',', '')))),
                        // ),
                      );
                    })))
          ],
        ));
  }
}
