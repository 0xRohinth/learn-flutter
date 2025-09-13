class Product {
  final int? id;
  final String name;
  final String sellerName;
  final String unit;
  final double b2bPrice;   // instead of purchasePrice
  final double b2cPrice;   // instead of sellingPrice
  final int stockQty;      // instead of stock
  final String notes;

  Product({
    this.id,
    required this.name,
    required this.sellerName,
    required this.unit,
    required this.b2bPrice,
    required this.b2cPrice,
    required this.stockQty,
    required this.notes,
  });

  // Convert Product -> Map (for SQLite insert/update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sellerName': sellerName,
      'unit': unit,
      'b2bPrice': b2bPrice,
      'b2cPrice': b2cPrice,
      'stockQty': stockQty,
      'notes': notes,
    };
  }

  // Convert Map -> Product (for reading from SQLite)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      sellerName: map['sellerName'] as String,
      unit: map['unit'] as String,
      b2bPrice: (map['b2bPrice'] as num).toDouble(),
      b2cPrice: (map['b2cPrice'] as num).toDouble(),
      stockQty: map['stockQty'] as int,
      notes: map['notes'] as String,
    );
  }
}
