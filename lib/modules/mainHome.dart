import 'package:employee_manager/bloc/allBloc.dart';
import 'package:employee_manager/components/colors.dart';
import 'package:employee_manager/components/textStyle.dart';
import 'package:employee_manager/modules/addEmployee/addEmployee.dart';
import 'package:employee_manager/modules/currentEmployees/currentEmployees.dart';
import 'package:employee_manager/modules/previousEmployees/previousEmployees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubic = context.read<AllListCubit>();
      cubic.fetch();
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
      body: BlocBuilder<AllListCubit, AllListState>(builder: (context, state) {
        if (state is IsEmptyState)
          return Center(child: SvgPicture.asset("assets/empty.svg"));
        else if (state is IsNotEmptyState)
          return ListView(
            children: [
              CurrentEmployees(),
              PreviousEmpolyees(),
            ],
          );
        else
          return Center(
            child: Text("An error occured"),
          );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (builder) => AddEmployee(
                      isEdit: false,
                    )),
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
}
