import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    // tablodan verileri almak için ekleme metodu
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    // static yöntem oldugundan class ismini tekrarlamamız gerekir.
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    // verileri almak istedipimiz tabloyu alır ve tablodaki tüm verileri döndürür.
    final db = await DBHelper.database();
    return db.query(table);
  }
}
