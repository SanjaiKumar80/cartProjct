import 'package:cart/model/cart__model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

class CartDbProvider {
  
  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "cart.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE Product(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
         productName,
         modelNumber,
         price,
         manufactureDate,manufactureAddress,productType
      )""");
      await db.execute("""
    CREATE TABLE IF NOT EXISTS User (
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,
    userName,
    password,
   dob,
    )
  """);
    });
  }

  Future<int> addItem(CartDataModel item, tableName) async {
    final db = await init();
    return db.insert(
      tableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<CartDataModel>> fetchProduct(tableName) async {
    final db = await init();
    final maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return CartDataModel(
        id: maps[i]['id'] as int,
        manufactureAddress: maps[i]['manufactureAddress'] != null
            ? maps[i]['manufactureAddress'] as String
            : "null",
        manufactureDate: maps[i]['manufactureDate'] != null
            ? maps[i]['manufactureDate'] as String
            : "null",
        modelNumber: maps[i]['modelNumber'] != null
            ? maps[i]['modelNumber'] as String
            : "null",
        price: maps[i]['price'] != null ? maps[i]['price'] as String : "null",
        productName: maps[i]['productName'] != null
            ? maps[i]['productName'] as String
            : "null",
        productType: maps[i]['productType'] != null
            ? maps[i]['productType'] as String
            : "null",
      );
    });
  }

  Future<int> deleteCart(int id, tableName) async {
 
    final db = await init();

    int result = await db.delete(tableName, 
        where: "id = ?",
        whereArgs: [id] 
        );

    return result;
  }

  Future<int> updateCart(int id, CartDataModel item, tableName) async {
 

    final db = await init();

    int result = await db
        .update(tableName, item.toJson(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}
