import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('stock_manager.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print("DB Path: $path");

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    print("Creating products table...");
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        sellerName TEXT,
        unit TEXT,
        purchasePrice REAL,
        sellingPrice REAL,
        stock INTEGER
      )
    ''');
  }

  Future<int> insertProduct(Product product) async {
    final db = await instance.database;
    final id = await db.insert('products', product.toMap());
    print("Inserted product with id: $id");
    return id;
  }

  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final result = await db.query('products');
    print("Fetched products: $result");
    return result.map((json) => Product.fromMap(json)).toList();
  }
}
