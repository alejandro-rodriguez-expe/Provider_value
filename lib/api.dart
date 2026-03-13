import 'package:dio/dio.dart';
import 'package:provider_value/product.dart';

class Api {
  final Dio dio;

  Api({required this.dio});

  Future<List<Product>> getProducts() async {
    final response = await dio.get('https://fakestoreapi.com/products');
    return (List<Map<String, dynamic>>.from(response.data) as List<dynamic>)
        .map((e) => Product.fromJson(e))
        .toList();
  }
}
