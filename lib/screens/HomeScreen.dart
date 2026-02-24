import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/core/app_assets.dart';
import '../core/app_routes.dart';
import '../providers/product_provider.dart';
import '../model/product_response.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false)
          .loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title:Image.asset(AppAssets.logo),
          actions: [
            Consumer<ProductProvider>(
              builder: (context, provider, _) {
                return Stack(
                  children: [
                  InkWell(child: Image.asset(AppAssets.cart),
                      onTap: () {
                      Navigator.pushNamed(context, AppRoutes.cartScreen);
                    },
                  ),


                    if (provider.cart.isNotEmpty)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            provider.cart.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            )
          ],
        ),

        body: provider.isLoading
            ? const Center(child: CircularProgressIndicator())

            : provider.error != null
            ? Center(child: Text(provider.error!))

            : provider.products.isEmpty
            ? const Center(child: Text("No Products Found"))

            : Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: provider.products.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {

              Products product =
              provider.products[index];

              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(12),
                        child: Image.network(
                          product.thumbnail ?? "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      product.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 16,
                            color: Colors.orange),
                        Text(
                            "${product.rating ?? 0}"),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "${product.price ?? 0} EGP",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          provider.addToCart(product);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}