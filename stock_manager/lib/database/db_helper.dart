import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class DBHelper {
  static Database? _database;
  static const String dbName = "stock_manager.db";

  // Initialize DB
  static Future<Database> initDB() async {
    if (_database != null) return _database!;
    final path = join(await getDatabasesPath(), dbName);
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            sellerName TEXT,
            unit TEXT,
            b2bPrice REAL,
            b2cPrice REAL,
            stockQty INTEGER,
            notes TEXT
          )
        ''');
      },
    );
    return _database!;
  }

  // Insert Product
  static Future<int> insertProduct(Product product) async {
    final db = await initDB();
    return await db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get All Products
  static Future<List<Product>> getProducts() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  // Update Product
  static Future<int> updateProduct(Product product) async {
    final db = await initDB();
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Delete Product
  static Future<int> deleteProduct(int id) async {
    final db = await initDB();
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
