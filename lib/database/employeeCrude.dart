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

  updateEmployee(int id, String qty) async {
    final db = await database;
    var res =
        await db!.rawUpdate("UPDATE employee SET quantity=$qty WHERE id=$id");
    return res;
  }
}
