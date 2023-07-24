import 'package:employee_manager/components/colors.dart';
import 'package:employee_manager/components/textStyle.dart';
import 'package:employee_manager/modules/addEmployee/addEmployee.dart';
import 'package:employee_manager/modules/currentEmployees/currentEmployees.dart';
import 'package:employee_manager/modules/previousEmployees/previousEmployees.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  List<Widget> _tabs = [CurrentEmployees(), PreviousEmpolyees()];
  List<String> _tabsTitle = ['Current', 'Previous'];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            dividerColor: grey,
            indicatorColor: primaryColor,
            labelStyle: h3Primary,
            labelColor: primaryColor,
            unselectedLabelStyle: h4Black,
            tabs: _tabsTitle
                .map(
                  (String name) => Tab(
                    text: name,
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(children: _tabs),
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
      ),
    );
  }
}
