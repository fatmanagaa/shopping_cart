
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/product_response.dart';
import 'api_constants.dart';
import 'api_endpoints.dart';

Future<ProductResponse> getProducts() async {
  Uri url = Uri.https(
    ApiConstants.baseUrl,
    ApiEndpoints.products,
  );

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      return ProductResponse.fromJson(responseJson);
    } else {
      throw Exception("Failed to load products");
    }
  } catch (e) {
    rethrow;
  }
}