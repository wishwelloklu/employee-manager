import 'package:employee_manager/bloc/employeeListCubit.dart';
import 'package:employee_manager/bloc/employeeListState.dart';
import 'package:employee_manager/modules/addEmployee/widget/addEmployeeWidget.dart';
import 'package:employee_manager/components/button.dart';
import 'package:employee_manager/modules/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/colors.dart';
import '../../components/textStyle.dart';
import 'package:intl/intl.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeListCubit, EmployeeListState>(
        builder: (_, state) {
      return AddEmployeeWidget(state);
    });
  }
}

class AddEmployeeWidget extends StatefulWidget {
  final EmployeeListState? state;

  AddEmployeeWidget(this.state);

  @override
  State<AddEmployeeWidget> createState() => _AddEmployeeWidgetState();
}

class _AddEmployeeWidgetState extends State<AddEmployeeWidget> {
  final _employeeController = TextEditingController();
  final _roleController = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  final DateFormat formatter = DateFormat('d MMM yyyy');

  final _employeeFocus = FocusNode();
  final _roleFocus = FocusNode();

  List<String> positionsList = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Add Employee Details",
          style: h3WhiteBold,
        ),
      ),
      body: Stack(
        children: [
          addEmployeeWidget(
            context: context,
            key: _globalKey,
            employeeController: _employeeController,
            roleController: _roleController,
            employeeFocus: _employeeFocus,
            roleFocus: _roleFocus,
            formatter: formatter,
            startDate: _startDate,
            endDate: _endDate ?? null,
            onDropDown: () => _showModalSheet(),
            onEnd: () => _onStart(false),
            onStart: () => _onStart(true),
          ),
          if (widget.state is LoadingEmployeeListState)
            Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              button(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => Homepage()),
                    (route) => false),
                text: "Cancel",
                color: primaryColor.withOpacity(.15),
                textColor: primaryColor,
                context: context,
                textStyle: h5,
                height: 35,
                useWidth: false,
              ),
              SizedBox(width: 10),
              button(
                onPressed: () => context.read<EmployeeListCubit>().saveEmployee(
                      name: _employeeController.text.trim(),
                      role: _roleController.text.trim(),
                      startDate: _startDate.toIso8601String().split("T")[0],
                      endDate: _endDate!.toIso8601String().split("T")[0],
                      isUpdate: false,
                      context: context,
                    ),
                text: "Save",
                color: primaryColor,
                textColor: white,
                context: context,
                textStyle: h5,
                height: 35,
                useWidth: false,
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showModalSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      builder: (builder) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var role in positionsList) ...[
            GestureDetector(
              onTap: () => _onSelectRole(role),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(role),
              ),
            ),
            if (role != positionsList.last) Divider(thickness: .2)
          ],
        ],
      ),
    );
  }

  // _onEnd() {}

  _onStart(bool startDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
        DateTime.now().year + 5,
      ),

      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.light(primary: primaryColor),
          ),
          child: child!,
        );
      },
      onDatePickerModeChange: (value) {},

    );
    if (selectedDate != null) {
      if (!startDate) _endDate = selectedDate;
      if (startDate) _startDate = selectedDate;
    }
    setState(() {});
  }

  _onSelectRole(String role) {
    _roleController.text = role;
    Navigator.pop(context);
    setState(() {});
  }

}
