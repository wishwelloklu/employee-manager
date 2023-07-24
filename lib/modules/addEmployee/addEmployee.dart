import 'package:employee_manager/components/toastMessage.dart';
import 'package:employee_manager/database/employeeCrude.dart';
import 'package:employee_manager/database/saveEmployee.dart';
import 'package:employee_manager/model/employeesModel.dart';
import 'package:employee_manager/modules/addEmployee/widget/addEmployeeWidget.dart';
import 'package:employee_manager/components/button.dart';
import 'package:employee_manager/modules/mainHome.dart';
import 'package:employee_manager/repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/colors.dart';
import '../../components/textStyle.dart';
import 'package:intl/intl.dart';

class AddEmployee extends StatefulWidget {
  final bool isEdit;
  final EmployeeModel? model;
  AddEmployee({required this.isEdit, this.model});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _employeeController = TextEditingController();
  final _roleController = TextEditingController();

  bool _isLoading = false;

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
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _employeeController.text = widget.model!.name!;
      _roleController.text = widget.model!.role!;
      _startDate = DateTime.parse(widget.model!.startDate!);
      _endDate = DateTime.parse(widget.model!.endDate!);
    }

    print(_endDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: !widget.isEdit
              ? Text(
                  "Add Employee Details",
                  style: h3WhiteBold,
                )
              : Text(
                  "Edit Employee Details",
                  style: h3WhiteBold,
                ),
          actions: [
            if (widget.isEdit)
              IconButton(
                onPressed: () => _onSlideEmployee(widget.model!.id!),
                icon: Icon(
                  FontAwesomeIcons.trashCan,
                ),
                color: white,
              )
          ],
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
            if (_isLoading)
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
                      MaterialPageRoute(builder: (builder) => MainHome()),
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
                  onPressed: () => _onAddEmployee(),
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
      ),
    );
  }

  void _showModalSheet() {
    FocusScope.of(context).unfocus();
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

  Future<void> _onAddEmployee() async {
    EmployeeCrud crud = EmployeeCrud();
    setState(() => _isLoading = true);
    if (widget.isEdit) {
      int response = await crud.updateEmployee(
        name: _employeeController.text.trim(),
        role: _roleController.text.trim(),
        startDate: _startDate.toIso8601String().split("T")[0],
        endDate: _endDate!.toIso8601String().split("T")[0],
        id: widget.model!.id!,
      );
      setState(() => _isLoading = false);
      if (response == 1) {
        scaffoldToast(context: context, message: "Updated successful");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => MainHome()),
            (route) => false);
      } else {
        scaffoldToast(
            context: context, message: "Something went wrong. Try again");
        return;
      }
    } else {
      Map response = await saveEmployeeIntoDb(
        name: _employeeController.text.trim(),
        role: _roleController.text.trim(),
        startDate: _startDate.toIso8601String().split("T")[0],
        endDate: _endDate!.toIso8601String().split("T")[0],
        isUpdate: widget.isEdit,
      );
      setState(() => _isLoading = false);
      if (response['ok']) {
        scaffoldToast(context: context, message: response['msg']);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => MainHome()),
            (route) => false);
      } else {
        scaffoldToast(context: context, message: response['msg']);
        return;
      }
    }
  }

  _onSlideEmployee(int id) async {
    EmployeeCrud crud = EmployeeCrud();
    Repository repository = Repository();
    int response = await crud.deleteEmployee(id);
    if (response == 1) {
      scaffoldToast(context: context, message: "Employee deleted");
      await repository.fetchCurrentEmployees();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => MainHome()),
          (route) => false);
      return;
    }
  }
}
