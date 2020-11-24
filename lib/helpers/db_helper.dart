import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath();
    final sqlDb = await sql.openDatabase(path.join(dbPath, "places.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places(id TEXT PRİMARY KEY, title TEXT, image TEXT)");
    }, version: 1);
    // Buraya kadar veritabanını kesinlikle açıyoruz, ancak oraya hiçbir şey eklemiyoruz,
    // bunun yerine sadece veritabanımızı oluşturmak için bu komutu çalıştırıyoruz.

    await sqlDb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
}
