import 'package:employee_manager/bloc/currentEmployeesBloc/employeeListCubit.dart';
import 'package:employee_manager/bloc/currentEmployeesBloc/employeeListState.dart';
import 'package:employee_manager/modules/addEmployee/addEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../model/employeesModel.dart';
import 'widget/currentEmployeesWidget.dart';

class CurrentEmployees extends StatefulWidget {
  const CurrentEmployees({super.key});

  @override
  State<CurrentEmployees> createState() => _CurrentEmployeesState();
}

class _CurrentEmployeesState extends State<CurrentEmployees> {
  final DateFormat formatter = DateFormat('d MMM yyyy');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubic = context.read<EmployeeListCubit>();
      cubic.fetchEmployeeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeListCubit, EmployeeListState>(
      builder: (context, state) {
        if (state is LoadingEmployeeListState || state is InitEmployeeListState)
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        else if (state is GetEmployeeListState) {
          if (state.response!.employeeModelList!.isNotEmpty)
            return _mainContent(context, state.response, state);
          else
            return SizedBox.shrink();
        } else if (state is ErrorEmployeeListState)
          return Center(
            child: Text(state.message),
          );

        return Center(
          child: Text(state.toString()),
        );
      },
      // ),
    );
  }

  Widget _mainContent(BuildContext context,
      EmployeeModelList? employeeModelList, EmployeeListState state) {
    return Stack(
      children: [
        currentEmployeesWidget(
          context: context,
          formatter: formatter,
          list: employeeModelList,
          onSlideToDelete: (id) =>
              context.read<EmployeeListCubit>().deleteEmplyee(id, context),
          onEmplopyee: (EmployeeModel model) => _onEmployee(model),
        )
      ],
    );
  }

  _onEmployee(EmployeeModel model) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (builder) => AddEmployee(isEdit: true, model: model)),
        (route) => false);
  }
}
