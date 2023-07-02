import 'package:employee_manager/database/employeeCrude.dart';

class EmployeeModel {
  int? id;
  String? name;
  String? role;
  String? startDate;
  String? endDate;
  int? deleted;

  EmployeeModel({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
    this.deleted,
  });
}

class EmployeeModelList {
  List<EmployeeModel>? employeeModelList;
  EmployeeModelList({required this.employeeModelList});
}

EmployeeModelList _employeeModelList = EmployeeModelList(employeeModelList: []);

Future<EmployeeModelList> getAllEmployees() async {
  EmployeeCrud crud = EmployeeCrud();
  _employeeModelList.employeeModelList!.clear();
  Future meta = crud.getEmployees();
  await meta.then((value) {
    for (var data in value) {
      _employeeModelList.employeeModelList!.add(
        EmployeeModel(
          id: data["id"],
          name: data['name'],
          role: data['role'],
          startDate: data['startDate'],
          endDate: data['endDate'],
          deleted: data['deleted'],
        ),
      );
    }
  });

  return _employeeModelList;
}
