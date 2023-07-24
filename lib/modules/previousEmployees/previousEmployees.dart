import 'package:employee_manager/modules/previousEmployees/widget/previousEmployeesWidget.dart';
import 'package:employee_manager/provider/previousEmployeesProvider.dart';
import 'package:employee_manager/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../model/previousEmployeesModel .dart';

class PreviousEmpolyees extends StatefulWidget {
  const PreviousEmpolyees({super.key});

  @override
  State<PreviousEmpolyees> createState() => _PreviousEmpolyeesState();
}

class _PreviousEmpolyeesState extends State<PreviousEmpolyees> {
  final DateFormat formatter = DateFormat('d MMM yyyy');
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    repository.fetchPreviouEmployees();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: previousEmployeesStream,
        initialData: previousEmployeeModelList ?? null,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.previousEmployeeModelList!.isNotEmpty) {
            if (snapshot.data!.previousEmployeeModelList!.isNotEmpty) {
              return _mainContent(context, snapshot.data);
            }
          } else if (!snapshot.hasData ||
              snapshot.data!.previousEmployeeModelList!.isEmpty)
            return Center(child: SvgPicture.asset("assets/empty.svg"));

          return Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }

  Widget _mainContent(
      BuildContext context, PreviousEmployeeModelList? employeeModelList) {
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
