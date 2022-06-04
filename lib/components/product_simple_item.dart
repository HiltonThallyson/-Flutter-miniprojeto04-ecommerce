import 'package:f6_ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductSimpleView extends StatelessWidget {
  final Product product;

  ProductSimpleView(this.product);

  @override
  Widget build(BuildContext context) {
    final String title = product.title;
    final String imgUrl = product.imageUrl;

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
                      .pushNamed(AppRoutes.EDIT_PRODUCT, arguments: product);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            IconButton(
              onPressed: () {},
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
