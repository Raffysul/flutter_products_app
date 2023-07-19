import 'dart:convert';
import 'package:http/http.dart';
import '../model/products_model.dart';


class ProductApiService {
  String endpoint = 'https://api.escuelajs.co/api/v1/products';
  Future<List<ProductModel>> getProducts() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map(((e) => ProductModel.fromJson(e))).toList();
    } else {
      throw Exception('Failed to load product');
    }
  }
}