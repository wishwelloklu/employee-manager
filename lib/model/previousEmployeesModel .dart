import 'package:employee_manager/database/employeeCrude.dart';

class PreviousEmployeeModel {
  int? id;
  String? name;
  String? role;
  String? startDate;
  String? endDate;
  int? deleted;

  PreviousEmployeeModel({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
    this.deleted,
  });
}

class PreviousEmployeeModelList {
  List<PreviousEmployeeModel>? previousEmployeeModelList;
  PreviousEmployeeModelList({required this.previousEmployeeModelList});
}

PreviousEmployeeModelList _previousEmployeeModelList =
    PreviousEmployeeModelList(previousEmployeeModelList: []);

Future<PreviousEmployeeModelList> getAllPreviousEmployees() async {
  EmployeeCrud crud = EmployeeCrud();
  _previousEmployeeModelList.previousEmployeeModelList!.clear();
  Future meta = crud.getPreviousEmployees();
  await meta.then((value) {
    for (var data in value) {
      _previousEmployeeModelList.previousEmployeeModelList!.add(
        PreviousEmployeeModel(
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

  return _previousEmployeeModelList;
}
