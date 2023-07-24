import 'package:employee_manager/provider/currentEmployeesProvider.dart';
import 'package:employee_manager/provider/previousEmployeesProvider.dart';

class Repository {
  CurrentEmployeesProvider _currentEmployeesProvider =
      CurrentEmployeesProvider();
  fetchCurrentEmployees() => _currentEmployeesProvider.fetchCurrentEmployees();

  PreviousEmpolyeesProvider _previousEmpolyeesProvider =
      PreviousEmpolyeesProvider();
  fetchPreviouEmployees() =>
      _previousEmpolyeesProvider.fetchPreviousEmployees();
}
