class Product {
  final int? id;
  final String name;
  final String sellerName; // instead of category
  final String unit;
  final double purchasePrice;
  final double sellingPrice;
  final int stock;

  Product({
    this.id,
    required this.name,
    required this.sellerName,
    required this.unit,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sellerName': sellerName,
      'unit': unit,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'stock': stock,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      sellerName: map['sellerName'],
      unit: map['unit'],
      purchasePrice: map['purchasePrice'],
      sellingPrice: map['sellingPrice'],
      stock: map['stock'],
    );
  }
}
