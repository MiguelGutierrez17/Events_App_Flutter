import 'dart:io';
import 'package:adventures_app/models/adventure.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'AdventuresDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        
        CREATE TABLE Adventures(
        id INTEGER PRIMARY KEY,
        title TEXT,
        date TEXT,
        place TEXT,
        img TEXT
        ) 
        ''');
    });
  }

  Future<int> newAdventure(Adventure createRequest) async {
    final db = await database;
    final response = await db.insert('Adventures', createRequest.toMap());
    return response;
  }

  Future<int> updateAdventure(Adventure updateRequest) async {
    final db = await database;
    final response = await db.update('Adventures', updateRequest.toMap(),
        where: 'id = ?', whereArgs: [updateRequest.id]);
    return response;
  }

  Future<int> deleteAdventureById(int id) async {
    final db = await database;
    final response =
        await db.delete('Adventures', where: 'id = ?', whereArgs: [id]);
    return response;
  }

  Future<List<Adventure>> getAllAdventures() async {
    final db = await database;
    final response = await db.query('Adventures', orderBy: 'date ASC');
    return response.isNotEmpty
        ? response.map((adv) => Adventure.fromMap(adv)).toList()
        : [];
  }

  Future<Adventure?> getAdventureById(int id) async {
    final db = await database;
    final response =
        await db.query('Adventure', where: 'id = ?', whereArgs: [id]);
    return response.isNotEmpty ? Adventure.fromMap(response.first) : null;
  }
}
