import 'package:employee_manager/model/previousEmployeesModel%20.dart';

abstract class PreviousEmployeeListState {}

class InitPreviousEmployeeListState extends PreviousEmployeeListState {}

class GetPreviousEmployeeListState extends PreviousEmployeeListState {
  final PreviousEmployeeModelList response;
  GetPreviousEmployeeListState(this.response);
}

class ErrorPreviousEmployeeListState extends PreviousEmployeeListState {
  final String message;
  ErrorPreviousEmployeeListState(this.message);
}

class LoadingPreviousEmployeeListState extends PreviousEmployeeListState {}