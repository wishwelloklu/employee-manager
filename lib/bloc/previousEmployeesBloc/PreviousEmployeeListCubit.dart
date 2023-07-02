import 'package:employee_manager/database/employeeCrude.dart';
import 'package:employee_manager/model/previousEmployeesModel%20.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PreviousEmployeeListState.dart';

class PreviousEmployeeListCubit extends Cubit<PreviousEmployeeListState> {
  final EmployeeCrud crud;
  PreviousEmployeeListCubit(this.crud) : super(InitPreviousEmployeeListState());

  Future fetchPreviousEmployeeList() async {
    emit(LoadingPreviousEmployeeListState());
    try {
      final response = await getAllPreviousEmployees();
      emit(GetPreviousEmployeeListState(response));
    } on Exception catch (e) {
      emit(ErrorPreviousEmployeeListState(e.toString()));
    }
  }
}
