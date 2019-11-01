import 'dart:async';
import 'dart:io';
import 'package:flutter_sqlite/model/dog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider db = DBProvider();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Dogs.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE DOG ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "age INTEGER"
          ")");
    });
  }

  newDog(Dog dog) async {
    final db = await database;
    var query = await db.rawInsert(
        "INSERT into DOG (name, age)"
        " VALUES (?, ?)",
        [dog.name, dog.age]);
    return query;
  }

  deleteDog(int id) async {
    final db = await database;
    return db.rawDelete("Delete from DOG where id = ?", [id]);
  }

  Future<List<Dog>> getAllDogs() async {
    final db = await database;
    var query = await db.query("DOG");
    List<Dog> list =
        query.isNotEmpty ? query.map((c) => Dog.fromMap(c)).toList() : [];
    return list;
  }
}
