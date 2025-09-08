import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import 'add_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductProvider>(context, listen: false).fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(title: const Text("Stock Manager")),
      body: products.isEmpty
          ? const Center(child: Text("No products yet. Add some!"))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, index) {
                final Product product = products[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                        "Seller: ${product.sellerName}\nStock: ${product.stock} ${product.unit}"),
                    trailing: Text("₹${product.sellingPrice}"),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
          // reload after returning
          Provider.of<ProductProvider>(context, listen: false).fetchProducts();
        },
      ),
    );
  }
}
