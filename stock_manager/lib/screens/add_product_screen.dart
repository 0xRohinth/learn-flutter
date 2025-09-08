import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String sellerName = "";
  String unit = "";
  double purchasePrice = 0.0;
  double sellingPrice = 0.0;
  int stock = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Product Name"),
                onSaved: (val) => name = val ?? "",
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Seller Name"),
                onSaved: (val) => sellerName = val ?? "",
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Unit"),
                onSaved: (val) => unit = val ?? "",
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Purchase Price"),
                keyboardType: TextInputType.number,
                onSaved: (val) =>
                    purchasePrice = double.tryParse(val ?? "0") ?? 0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Selling Price"),
                keyboardType: TextInputType.number,
                onSaved: (val) =>
                    sellingPrice = double.tryParse(val ?? "0") ?? 0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
                onSaved: (val) => stock = int.tryParse(val ?? "0") ?? 0,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  _formKey.currentState?.save();
                  final product = Product(
                    name: name,
                    sellerName: sellerName,
                    unit: unit,
                    purchasePrice: purchasePrice,
                    sellingPrice: sellingPrice,
                    stock: stock,
                  );
                  Provider.of<ProductProvider>(context, listen: false)
                      .addProduct(product);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
