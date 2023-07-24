import 'package:employee_manager/database/employeeCrude.dart';
import 'package:rxdart/subjects.dart';

import '../model/employeesModel.dart';

final _fetcher = PublishSubject<EmployeeModelList>();

Stream<EmployeeModelList> currentEmployeesStream = _fetcher.stream;
Sink<EmployeeModelList> currentEmployeesSink = _fetcher.sink;

EmployeeModelList? employeeModelList;

class CurrentEmployeesProvider {
  EmployeeCrud employeeCrud = EmployeeCrud();
  fetchCurrentEmployees() async {
    employeeModelList = await getAllEmployees();
    if (employeeModelList != null) {
      currentEmployeesSink.add(employeeModelList!);
    } else {
      employeeModelList = null;
      currentEmployeesSink.add(employeeModelList!);
    }
  }
}
