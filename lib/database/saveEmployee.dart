import 'package:employee_manager/database/employeeCrude.dart';
import 'package:employee_manager/model/employeesModel.dart';
import 'package:sqflite/sqflite.dart';

Future<Map<String, dynamic>> saveEmployeeIntoDb({
  required String name,
  required String role,
  required String startDate,
  required String endDate,
  required bool isUpdate,
}) async {
  try {
    var newEmployee = EmployeeModel(
      name: name,
      role: role,
      startDate: startDate,
      endDate: endDate,
    );
    EmployeeCrud employeeCrud = EmployeeCrud();
    employeeCrud.addEmployee(newEmployee);

    return {
      "ok": true,
      "msg": "Employee details ${isUpdate ? 'updated' : 'added'} ...",
    };
  } on DatabaseException catch (e) {
    print(e);
    return {
      "ok": false,
      "msg": e.toString(),
    };
  }
}
