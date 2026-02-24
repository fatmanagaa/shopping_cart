
import '../model/product_response.dart';
import 'api_manger.dart';
import 'api_manger.dart' as ApiManger;

class ProductService {

  Future<List<Products>> fetchProducts() async {

    ProductResponse response = await ApiManger.getProducts();

    return response.products ?? [];
  }

}