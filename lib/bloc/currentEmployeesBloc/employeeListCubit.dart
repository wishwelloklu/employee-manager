import 'package:employee_manager/bloc/previousEmployeesBloc/PreviousEmployeeListCubit.dart';
import 'package:employee_manager/components/toastMessage.dart';
import 'package:employee_manager/database/employeeCrude.dart';
import 'package:employee_manager/database/saveEmployee.dart';
import 'package:employee_manager/model/employeesModel.dart';
import 'package:employee_manager/modules/mainHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employeeListState.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  final EmployeeCrud crud;
  EmployeeListCubit(this.crud) : super(InitEmployeeListState());

  Future fetchEmployeeList() async {
    emit(LoadingEmployeeListState());
    try {
      final response = await getAllEmployees();
      emit(GetEmployeeListState(response));
    } on Exception catch (e) {
      emit(ErrorEmployeeListState(e.toString()));
    }
  }

  bool _isLoading = false;

  bool getLoading() => _isLoading;

  Future saveEmployee({
    @required String? name,
    @required String? role,
    @required String? startDate,
    @required String? endDate,
    @required bool? isUpdate,
    @required BuildContext? context,
  }) async {
    emit(LoadingEmployeeListState());
    Map response = await saveEmployeeIntoDb(
      name: name!,
      role: role!,
      startDate: startDate!,
      endDate: endDate!,
      isUpdate: false,
    );
    if (response['ok']) {
      emit(SaveCompleteState(response));
      scaffoldToast(
        context: context!,
        message: response['msg'],
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => MainHome()),
          (route) => false);
    } else {
      emit(NotLoadingEmployeeListState());
      scaffoldToast(
        context: context!,
        message: response['msg'],
      );
    }
  }

  Future deleteEmplyee(int id, BuildContext context) async {
    EmployeeCrud employeeCrud = EmployeeCrud();
    try {
      emit(LoadingEmployeeListState());
      var response = await employeeCrud.deleteEmployee(id);

      if (response == 1) {
        final cubic = context.read<PreviousEmployeeListCubit>();
        await cubic.fetchPreviousEmployeeList();
        await fetchEmployeeList();

        scaffoldToast(
          context: context,
          message: "Employee data has been deleted",
          onTap: () async => undoDelete(id, context),
          duration: Duration(seconds: 10),
        );
      } else {
        scaffoldToast(
          context: context,
          message: "An error occured",
        );
      }
    } on Exception catch (e) {
      emit(NotLoadingEmployeeListState());
      scaffoldToast(
        context: context,
        message: e.toString(),
      );
    }
  }

  Future undoDelete(int id, BuildContext context) async {
    EmployeeCrud employeeCrud = EmployeeCrud();
    emit(LoadingEmployeeListState());
    var response = await employeeCrud.undoDelete(id);
    print(response);
    if (response == 1) {
      final cubic = context.read<PreviousEmployeeListCubit>();
      await cubic.fetchPreviousEmployeeList();
      await fetchEmployeeList();
    }
  }

  Future updateDetails({
    required BuildContext context,
    required int id,
    required String name,
    required String role,
    required String startDate,
    required String endDate,
  }) async {
    EmployeeCrud employeeCrud = EmployeeCrud();
    emit(LoadingEmployeeListState());
    var response = await employeeCrud.updateEmployee(
      id: id,
      name: name,
      role: role,
      startDate: startDate,
      endDate: endDate,
    );
    print(response);
    if (response == 1) {
      await fetchEmployeeList();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => MainHome()),
          (route) => false);
    }
  }
}
