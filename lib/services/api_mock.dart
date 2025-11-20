import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sticky_flutter_shop/models/products.dart';

class ApiMock {
  static Future<List<Product>> fetchProducts() async {
    final jsonString = await rootBundle.loadString('assets/mock/products.json');
    final List data = json.decode(jsonString);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  static Future<Product> fetchProduct(int id) async {
    final products = await fetchProducts();
    return products.firstWhere((p) => p.id == id);
  }
}
