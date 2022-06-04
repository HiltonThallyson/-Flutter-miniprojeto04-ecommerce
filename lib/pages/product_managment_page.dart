import 'package:f6_ecommerce/components/my_drawer.dart';
import 'package:f6_ecommerce/components/product_simple_item.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../model/product_list.dart';
import '../utils/app_routes.dart';

class ProductManagementPage extends StatefulWidget {
  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  static const snackBarPlaceAdded = SnackBar(
    content: Text('Um novo produto foi adicionado!'),
    duration: const Duration(seconds: 2),
  );

  void _snackBarHandler(bool isActive) {
    if (isActive) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(snackBarPlaceAdded);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var products = context.watch<ProductList>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(
                      AppRoutes.PRODUCT_FORM,
                    )
                    .then((result) => _snackBarHandler(result as bool));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: ((_, index) {
            return Column(
              children: [
                ProductSimpleView(products.items[index]),
                Divider(),
              ],
            );
          })),
      drawer: MyDrawer(),
    );
  }
}
