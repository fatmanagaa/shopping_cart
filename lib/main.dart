import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/providers/product_provider.dart';
import 'package:shopping_cart/screens/HomeScreen.dart';
import 'package:shopping_cart/screens/cart_screen.dart';

import 'core/app_routes.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ProductProvider(),
          ),
        ],
        child: MyApp(),
      ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {


        AppRoutes.homeScreen: (context) => HomeScreen(),
        AppRoutes.cartScreen: (context) => CartScreen(),



      },
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}