import 'package:f6_ecommerce/components/product_grid.dart';
import 'package:f6_ecommerce/components/product_item.dart';
import 'package:f6_ecommerce/data/dummy_data.dart';
import 'package:f6_ecommerce/model/cart_model.dart';
import 'package:f6_ecommerce/model/product.dart';
import 'package:f6_ecommerce/model/product_list.dart';
import 'package:f6_ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<ProductList>(context);
    var cart = context.select<CartModel, bool>(
        (cartProducts) => cartProducts.products.isNotEmpty);
    return Scaffold(
        appBar: AppBar(
          title: Text('Minha Loja'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_FORM,
                  );
                },
                icon: Icon(Icons.add)),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Somente Favoritos'),
                  value: FilterOptions.favorite,
                ),
                PopupMenuItem(
                  child: Text('Todos'),
                  value: FilterOptions.all,
                ),
              ],
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorite) {
                    //provider.showFavoriteOnly();
                    _showOnlyFavorites = true;
                  } else {
                    //provider.showAll();
                    _showOnlyFavorites = false;
                  }
                });
              },
            ),
          ],
        ),
        body: ProductGrid(_showOnlyFavorites),
        floatingActionButton: IconButton(
          onPressed: () => cart
              ? Navigator.of(context).pushNamed(AppRoutes.CART_VIEW)
              : null,
          icon: Icon(Icons.shopping_cart),
        ));
  }
}
