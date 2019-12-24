import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> getDatabaseTable(String tableName) async {
    final dbPath = await sql.getDatabasesPath();
    final sqlDB = await sql.openDatabase(path.join(dbPath, 'basic.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT,active INTEGER )");
    }, version: 1);

    return sqlDB;
  }

  static Future<void> insert(String tableName, Map<String, Object> data) async {
    final db = await DBHelper.getDatabaseTable(tableName);
    await db.insert(
      tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<Map<String, dynamic>> findFirst(String tableName) async {
    final db = await DBHelper.getDatabaseTable(tableName);
    final result = await db.query(tableName);
    if (result.isEmpty) {
      return null;
    }
    return result.first;
  }

  static Future<List<Map<String, dynamic>>> find(
      String tableName, Map<String, dynamic> arguments) async {
    final db = await DBHelper.getDatabaseTable(tableName);
    List<String> columns = arguments.keys.toList();

    return db.query(tableName,
        where: DBHelper.buildWhereClause(columns),
        whereArgs: arguments.values.toList() //we might have to change this
        );
  }

  static String buildWhereClause(List<String> columns) {
    String where = "";
    for (var i = 0; i < columns.length; i++) {
      where += "${columns[i]} = ? ";
      if (i != columns.length - 1) {
        where += "AND ";
      }
    }
    return where;
  }
}
