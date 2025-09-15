import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _sellerController;
  late TextEditingController _unitController;
  late TextEditingController _b2bController;
  late TextEditingController _b2cController;
  late TextEditingController _stockController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _sellerController = TextEditingController(text: widget.product.sellerName);
    _unitController = TextEditingController(text: widget.product.unit);
    _b2bController =
        TextEditingController(text: widget.product.b2bPrice.toString());
    _b2cController =
        TextEditingController(text: widget.product.b2cPrice.toString());
    _stockController =
        TextEditingController(text: widget.product.stockQty.toString());
    _notesController = TextEditingController(text: widget.product.notes);
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = Product(
        id: widget.product.id,
        name: _nameController.text,
        sellerName: _sellerController.text,
        unit: _unitController.text,
        b2bPrice: double.parse(_b2bController.text),
        b2cPrice: double.parse(_b2cController.text),
        stockQty: int.parse(_stockController.text),
        notes: _notesController.text,
      );

      await DBHelper.updateProduct(updatedProduct);

      if (mounted) Navigator.pop(context, true); // return true → refresh list
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: inputType,
      validator: (value) =>
          value == null || value.isEmpty ? "Enter $label" : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Product Name", _nameController),
              _buildTextField("Seller Name", _sellerController),
              _buildTextField("Unit", _unitController),
              _buildTextField("B2B Price", _b2bController,
                  inputType: TextInputType.number),
              _buildTextField("B2C Price", _b2cController,
                  inputType: TextInputType.number),
              _buildTextField("Stock Quantity", _stockController,
                  inputType: TextInputType.number),
              _buildTextField("Notes", _notesController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
