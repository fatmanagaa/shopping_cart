import 'package:flutter/material.dart';
import '../api/product_service.dart';
import '../model/product_response.dart';

class ProductProvider extends ChangeNotifier {

  List<Products> products = [];
  List<Products> cart = [];

  bool isLoading = false;
  String? error;

  double get totalPrice {
    return cart.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
  }

  Future<void> loadProducts() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      products = await ProductService().fetchProducts();

    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void addToCart(Products product) {
    cart.add(product);
    notifyListeners();
  }

  void removeLastFromCart() {
    if (cart.isNotEmpty) {
      cart.removeLast();
      notifyListeners();
    }
  }
}