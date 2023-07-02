import 'package:employee_manager/bloc/currentEmployeesBloc/employeeListState.dart';
import 'package:employee_manager/bloc/previousEmployeesBloc/PreviousEmployeeListCubit.dart';
import 'package:employee_manager/bloc/previousEmployeesBloc/PreviousEmployeeListState.dart';
import 'package:employee_manager/modules/previousEmployees/widget/previousEmployeesWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../model/previousEmployeesModel .dart';

class PreviousEmpolyees extends StatefulWidget {
  const PreviousEmpolyees({super.key});

  @override
  State<PreviousEmpolyees> createState() => _PreviousEmpolyeesState();
}

class _PreviousEmpolyeesState extends State<PreviousEmpolyees> {
  final DateFormat formatter = DateFormat('d MMM yyyy');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubic = context.read<PreviousEmployeeListCubit>();
      cubic.fetchPreviousEmployeeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousEmployeeListCubit, PreviousEmployeeListState>(
      builder: (context, state) {
        if (state is LoadingEmployeeListState || state is InitEmployeeListState)
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        else if (state is GetPreviousEmployeeListState) {
          if (state.response.previousEmployeeModelList!.isNotEmpty)
            return _mainContent(context, state.response, state);
          else
            return SizedBox.shrink();
        } else if (state is ErrorPreviousEmployeeListState)
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

  Widget _mainContent(
      BuildContext context,
      PreviousEmployeeModelList? employeeModelList,
      PreviousEmployeeListState state) {
    return Stack(
      children: [
        previousEmployeesWidget(
          context: context,
          formatter: formatter,
          list: employeeModelList,
        )
      ],
    );
  }
}
