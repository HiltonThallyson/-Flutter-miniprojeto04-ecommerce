import 'package:f6_ecommerce/model/cart.dart';
import 'package:f6_ecommerce/model/product_list.dart';
import 'package:f6_ecommerce/pages/edit_product_page.dart';
import 'package:f6_ecommerce/pages/mycart_page.dart';
import 'package:f6_ecommerce/pages/product_detail_page.dart';
import 'package:f6_ecommerce/pages/product_form_page.dart';
import 'package:f6_ecommerce/pages/product_managment_page.dart';
import 'package:f6_ecommerce/pages/products_overview_page.dart';
import 'package:f6_ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        )
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
            fontFamily: 'Lato',
            //primarySwatch: Colors.pink,
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                primary: Colors.pink, secondary: Colors.orangeAccent)),
        initialRoute: '/',
        routes: {
          AppRoutes.HOME: (context) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormPage(),
          AppRoutes.CART_VIEW: (context) => MyCart(),
          AppRoutes.PRODUCT_MANAGMENT: (context) => ProductManagementPage(),
          AppRoutes.EDIT_PRODUCT: (context) => EditProductPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
