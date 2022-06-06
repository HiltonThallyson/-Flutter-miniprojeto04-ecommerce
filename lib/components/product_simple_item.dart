import 'package:f6_ecommerce/model/cart.dart';
import 'package:f6_ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../model/product_list.dart';

class ProductSimpleView extends StatefulWidget {
  final Product product;

  ProductSimpleView(this.product);

  @override
  State<ProductSimpleView> createState() => _ProductSimpleViewState();
}

class _ProductSimpleViewState extends State<ProductSimpleView> {
  static const snackBarProductEdited = SnackBar(
    content: Text('Produto atualizado!'),
    duration: const Duration(seconds: 2),
  );

  static const snackBarProductRemoved = SnackBar(
    content: Text('Produto removido!'),
    duration: const Duration(seconds: 2),
  );

  void _snackBarHandler(bool isActive, SnackBar snack) {
    if (isActive) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(snack);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.product.title;
    final String imgUrl = widget.product.imageUrl;
    var provider = context.read<ProductList>();
    var cart = context.watch<CartModel>();

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.EDIT_PRODUCT,
                          arguments: widget.product)
                      .then((result) => _snackBarHandler(
                          result as bool, snackBarProductEdited));
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            IconButton(
              onPressed: () {
                provider.removeProduct(widget.product);
                cart.addOrRemoveItem(widget.product.id, widget.product.price,
                    widget.product.title);
                _snackBarHandler(true, snackBarProductRemoved);
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
