import 'package:employee_manager/components/toastMessage.dart';
import 'package:employee_manager/database/employeeCrude.dart';
import 'package:employee_manager/modules/addEmployee/addEmployee.dart';
import 'package:employee_manager/provider/currentEmployeesProvider.dart';
import 'package:employee_manager/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    repository.fetchCurrentEmployees();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: currentEmployeesStream,
        initialData: employeeModelList,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.employeeModelList!.isNotEmpty) {
            return _mainContent(context, snapshot.data);
          } else if (!snapshot.hasData ||
              snapshot.data!.employeeModelList!.isEmpty) {
            return Center(child: SvgPicture.asset("assets/empty.svg"));
          }
          return Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }

  Widget _mainContent(
    BuildContext context,
    EmployeeModelList? employeeModelList,
  ) {
    return Stack(
      children: [
        currentEmployeesWidget(
          context: context,
          formatter: formatter,
          list: employeeModelList,
          onSlideToDelete: (id) => _onSlideEmployee(id),
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

  _onSlideEmployee(int id) async {
    EmployeeCrud crud = EmployeeCrud();
    int response = await crud.deleteEmployee(id);
    if (response == 1) {
      scaffoldToast(context: context, message: "Employee deleted");
      repository.fetchCurrentEmployees();
      return;
    }
  }
}
