import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Future<Database> _database;
  final String _dbName = 'TDList.db';
  final int _dbVersion = 1;

  Future<Database> get database {
    if (_database != null) return _database;
    _database = initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);
    final Future<Database> database = openDatabase(path, version: _dbVersion,
        onCreate: (database, version) async {
      await database.execute('CREATE TABLE todo(title TEXT NOT NULL)');
    });
    return database;
  }

  Future<List> getData() async {
    final db = await database;
    Future<List> listData = db.rawQuery('SELECT title FROM todo');
    return listData;
  }

  Future<int> insertData(String title) async {
    final db = await database;
    return await db.insert('todo', {'title': title});
  }

  Future<int> deleteData(String title) async {
    final db = await database;
    return await db.delete('todo', where: 'title = ?', whereArgs: [title]);
  }
}
