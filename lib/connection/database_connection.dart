import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';

String table = 'user';

class DatabaseConnection {
  Future<Database> initializeUserDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'userData.db'),
      onCreate: ((db, version) async {
        await db
            .execute('CREATE TABLE $table(id INTEGER PRIMARY KEY, name TEXT )');
      }),
      version: 1,
    );
  }

  Future<void> insetUser(User user) async {
    final db = await initializeUserDB();
    await db.insert(table, user.toMap());
    print('function insert');
  }

  Future<List<User>> getUser() async {
    final db = await initializeUserDB();
    List<Map<String, dynamic>> qresult = await db.query(table);
    print('111');
    return qresult.map((e) => User.FromMap(e)).toList();
  }

  Future<void> deletedatabase(int id) async {
    final db = await initializeUserDB();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updatedatabase(User user) async {
    final db = await initializeUserDB();
    await db.update(table, user.toMap(), where: 'id=?', whereArgs: [user.id]);
  }
}
