import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../database/db_helper.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  // Load all products
  Future<void> loadProducts() async {
    _products = await DBHelper.getProducts();
    notifyListeners();
  }

  // Add new product
  Future<void> addProduct(Product product) async {
    await DBHelper.insertProduct(product);
    await loadProducts();
  }

  // Update existing product
  Future<void> updateProduct(Product product) async {
    await DBHelper.updateProduct(product);
    await loadProducts();
  }

  // Delete product by ID
  Future<void> deleteProduct(int id) async {
    await DBHelper.deleteProduct(id);
    await loadProducts();
  }
}
