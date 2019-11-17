import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const versionDB =1;
const DB_NAME = 'dog_db';
const COLUMN_ID= 'id';
const TABLE_NAME = 'Test';

class DbProvider {
  DbProvider._();

  static final DbProvider db = DbProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      return await _initDb();
    }
  }

  _initDb() async {
    return openDatabase(join(await getDatabasesPath(), 'dog_db'),
        version: versionDB,
        onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    // Database is created, create the table
    await db.execute(
        "CREATE TABLE Test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , age INTEGER)");
  }

}
