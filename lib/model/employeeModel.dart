import 'package:employee_manager/database/employeeCrude.dart';

class EmployeeModel {
  int? id;
  String? name;
  String? role;
  String? startDate;
  String? endDate;

  EmployeeModel({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
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
        ),
      );
    }
  });

  return _employeeModelList;
}
