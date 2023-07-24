
import 'package:employee_manager/database/employeeCrude.dart';
import 'package:employee_manager/model/previousEmployeesModel%20.dart';
import 'package:rxdart/subjects.dart';

final _fetcher = PublishSubject<PreviousEmployeeModelList>();

Stream<PreviousEmployeeModelList> previousEmployeesStream = _fetcher.stream;
Sink<PreviousEmployeeModelList> previousEmployeesSink = _fetcher.sink;

PreviousEmployeeModelList? previousEmployeeModelList;

class PreviousEmpolyeesProvider {
  EmployeeCrud employeeCrud = EmployeeCrud();
  fetchPreviousEmployees() async {
    previousEmployeeModelList = await getAllPreviousEmployees();
    if (previousEmployeeModelList != null) {
      previousEmployeesSink.add(previousEmployeeModelList!);
    } else {
      previousEmployeeModelList = null;
      previousEmployeesSink.add(previousEmployeeModelList!);
    }
  }
}