import 'package:employee_manager/database/databaseHelper.dart';
import 'package:employee_manager/model/employeeModel.dart';

class EmployeeCrud {
  final database = DatabaseHelper.db.database;

  addEmployee(EmployeeModel model) async {
    final db = await database;

    var response = await db!.rawInsert(
      '''
      INSERT INTO employee (
        name,
        role,
        startDate,
        endDate,
        deleted
      ) VALUES (?, ?, ?, ?, ?)
    ''',
      [
        model.name,
        model.role,
        model.startDate,
        model.endDate,
        0,
      ],
    );
    return response;
  }

  getEmployees() async {
    final db = await database;
    var res = await db!.rawQuery("SELECT * FROM employee WHERE deleted = 0");
    return res.toList();
  }

  undoDelete(int id) async {
    final db = await database;
    var res = await db!.rawDelete("UPDATE employee SET deleted=0 WHERE id=$id");
    return res;
  }

  deleteEmployee(int id) async {
    final db = await database;
    var res = await db!.rawDelete("UPDATE employee SET deleted=1 WHERE id=$id");
    return res;
  }

  updateEmployee({
    required int id,
    required String name,
    required String role,
    required String startDate,
    required String endDate,
  }) async {
    Map<String, dynamic> row = {
      "name": name,
      "role": role,
      "startDate": startDate,
      "endDate": endDate,
    };
    final db = await database;
    var res = await db!.update(DatabaseHelper.db.tableName, row,
        where: 'id=?', whereArgs: [id]);
    return res;
  }
}
