import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      print(" no new db created");
      return _database;
    }

    _database = await initDatabase();
    print("new db created");
    return _database;
  }

  initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'employee_database.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE employee (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              role TEXT,
              startDate TEXT,
              endDate TEXT,
              deleted INTEGER
            );
        ''');
      },
      version: 1,
    );
  }
}
