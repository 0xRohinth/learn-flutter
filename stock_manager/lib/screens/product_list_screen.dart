import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/product.dart';
import 'add_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];

  Future<void> _loadProducts() async {
    final products = await DBHelper.getProducts();
    setState(() => _products = products);
  }

  Future<void> _deleteProduct(int id) async {
    await DBHelper.deleteProduct(id);
    _loadProducts();
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: _products.isEmpty
          ? const Center(child: Text("No products found"))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      "Seller: ${product.sellerName}\n"
                      "Unit: ${product.unit}, Stock: ${product.stockQty}\n"
                      "B2B: ₹${product.b2bPrice}, B2C: ₹${product.b2cPrice}\n"
                      "Notes: ${product.notes}",
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AddProductScreen(product: product),
                              ),
                            );
                            if (updated == true) _loadProducts();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteProduct(product.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
          if (added == true) _loadProducts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
