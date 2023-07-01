import 'package:employee_manager/bloc/employeeListCubit.dart';
import 'package:employee_manager/bloc/employeeListState.dart';
import 'package:employee_manager/modules/addEmployee/addEmployee.dart';
import 'package:employee_manager/components/colors.dart';
import 'package:employee_manager/components/textStyle.dart';
import 'package:employee_manager/modules/homepage/widget/homepageWidget.dart';
import 'package:employee_manager/model/employeeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  EmployeeModelList? employeeModelList;

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: primaryColor,
        title: Text(
          "Employee List",
          style: h3WhiteBold,
        ),
      ),
      body: BlocBuilder<EmployeeListCubit, EmployeeListState>(
        builder: (context, state) {
          if (state is LoadingEmployeeListState ||
              state is InitEmployeeListState)
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          else if (state is GetEmployeeListState)
            return _mainContent(context, state.response, state);
          else if (state is ErrorEmployeeListState)
            return Center(
              child: Text(state.message),
            );

          return Center(
            child: Text(state.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => AddEmployee()),
            (route) => false),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _mainContent(BuildContext context,
      EmployeeModelList? employeeModelList, EmployeeListState state) {
    return Stack(
      children: [
        employeeModelList!.employeeModelList!.isNotEmpty
            ? homepageWidget(
                context: context,
                formatter: formatter,
                list: employeeModelList,
                onSlideToDelete: (direction, index, id) => context
                    .read<EmployeeListCubit>()
                    .deleteEmplyee(id, context),
              )
            : Center(
                child: SvgPicture.asset("assets/empty.svg"),
              ),
      ],
    );
  }

  // _onSlideToDelete(DismissDirection direction, int index, int id) async {
  //   await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text("Employee data has been deleted"),
  //     duration: Duration(seconds: 10),
  //     action: SnackBarAction(
  //         label: "Undo",
  //         onPressed: () {
  //           return;
  //         }),
  //   ));
  //   await Future.delayed(Duration(seconds: 10));

  // print(response);
  // if (response == 1) {
  //   setState(() => employeeModelList!.employeeModelList!.removeAt(index));
  // }
  // }
}
