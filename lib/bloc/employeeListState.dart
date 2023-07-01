import 'package:employee_manager/model/employeeModel.dart';

abstract class EmployeeListState {}

class InitEmployeeListState extends EmployeeListState {}

class GetEmployeeListState extends EmployeeListState {
  final EmployeeModelList response;
  GetEmployeeListState(this.response);
}

class SaveCompleteState extends EmployeeListState {
  final Map response;

  SaveCompleteState(this.response);
}

class ErrorEmployeeListState extends EmployeeListState {
  final String message;
  ErrorEmployeeListState(this.message);
}

class LoadingEmployeeListState extends EmployeeListState {}
class NotLoadingEmployeeListState extends EmployeeListState {}
