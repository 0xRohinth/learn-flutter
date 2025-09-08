import 'package:flutter/material.dart';
import '../models/product.dart';
import '../database/db_helper.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = await DBHelper.instance.getProducts();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await DBHelper.instance.insertProduct(product);
    await fetchProducts();
  }
}
