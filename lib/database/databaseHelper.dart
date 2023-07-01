import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();

  Database? _database;

  String databaseName = "employee_database.db";
  String tableName = "employee";

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
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
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
