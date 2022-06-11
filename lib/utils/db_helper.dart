import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../models/metWith.dart';
import 'package:CovidTracker/models/model.dart';

abstract class DBHelper {
  static Database? _db;

  static int get _version => 2;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      var dbPath = await getDatabasesPath();
      String _path = p.join(dbPath, "virustracker.db");
      _db = await openDatabase(_path,
          version: _version, onCreate: onCreate, onUpgrade: onUpgrade);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE contacts (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,uid TEXT NOT NULL, contactUid TEXT NOT NULL, date TEXT NOT NULL, latitude REAL NOT NULL, longitude REAL NOT NULL)';
    await db.execute(sql);
  }

  static Future<void> onUpgrade(
      Database db, int oldVersion, int version) async {
    if (oldVersion > version) {}
  }

  static Future<List<Map<String, dynamic>>> queryAll(String table) async {
    return _db!.query(table);
  }

  static Future<List<Map<String, dynamic>>> query(String table, String uid) async {
    return _db!.query(table, where: 'uid = ?', whereArgs: [uid]);
  }

  static Future<List<Map<String, dynamic>>> queryContact(String table, String uid, String contactUid) async {
    return _db!.query(table, where: 'uid = ? AND contactUid = ?', whereArgs: [uid, contactUid]);
  }

  static Future<int> deleteContact(String table, String uid, String contactUid) async {
    return await _db!.delete(table, where: 'uid = ? AND contactUid = ?', whereArgs: [uid, contactUid]);
  }

  static Future<int> insert(String table, Model model) async {
    return await _db!.insert(table, model.toJson());
  }

  static Future<int> update(String table, metWith model) async {
    return await _db!.update(table, model.toJson(),
        where: 'uid = ?', whereArgs: [model.uid]);
  }

  static Future<int> delete(String table, metWith model) async {
    return await _db!.delete(table, where: 'uid = ?', whereArgs: [model.uid]);
  }
  
}
