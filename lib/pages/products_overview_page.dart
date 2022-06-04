import 'package:f6_ecommerce/components/my_drawer.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<ProductList>(context, listen: false).fetchProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

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
    //final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.CART_VIEW),
              icon: Icon(Icons.shopping_cart)),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showOnlyFavorites),
      drawer: MyDrawer(),
    );
  }
}

// async {
//               await Navigator.of(context)
//                   .pushNamed(
//                     AppRoutes.PRODUCT_FORM,
//                   )
//                   .then((result) => _snackBarHandler(result as bool));
//             }
