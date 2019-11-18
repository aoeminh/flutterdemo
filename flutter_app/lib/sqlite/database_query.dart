import 'package:flutter_app/sqlite/database.dart';
import 'package:flutter_app/sqlite/db_contract.dart';
import 'package:flutter_app/sqlite/dog.dart';
import 'package:sqflite/sqflite.dart';

class DbQuery implements DbContract {
  @override
  Future<List<Dog>> getAllDog() async {
    final db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    List<Dog> dogs = maps.map((dog) => Dog.fromJson(dog)).toList();
    return dogs;
  }

  @override
  Future<List<Dog>> getDogById(int id) async {
    final db = await DbProvider.db.database;
    List<Map<String, dynamic>> dogMap =
        await db.query(TABLE_NAME, where: COLUMN_ID, whereArgs: ['$id']);
    List<Dog> dogs = dogMap.map((dog) => Dog.fromJson(dog)).toList();
    return dogs;
  }

  @override
  Future<int> insertDog(String name, int age) async {
    final db = await DbProvider.db.database;

    return await db.insert(TABLE_NAME, Dog(name: name, age: age).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> editDog(int id) {
    return null;
  }

  @override
  closeDb() async {
    // TODO: implement closeDb
    final db = await DbProvider.db.database;
    db.close();
  }
}
