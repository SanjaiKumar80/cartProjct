import 'package:cart/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

class UserDbProvider {
  String name = "";
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
   dob
    )
  """);
    });
  }

  Future<int> addItem(UserDataModel item, tableName) async {
    final db = await init();

    try {
      db.insert(
        tableName,
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return 1;
    } catch (e) {
      db.close();
      return 0;
    }
  }

  Future<int> checkLogin(String userName, String password) async {
    final dbClient = await init();

    var res = await dbClient.rawQuery(
        "SELECT * FROM User WHERE username = '$userName' and password = '$password'");

    if (res.isNotEmpty) {
      return 1;
    }

    return 0;
  }
}
