import 'package:employee_manager/components/colors.dart';
import 'package:employee_manager/components/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/src/intl/date_format.dart';

Widget addEmployeeWidget({
  required BuildContext context,
  required void Function() onDropDown,
  required void Function() onStart,
  required void Function() onEnd,
  required TextEditingController employeeController,
  required TextEditingController roleController,
  required FocusNode employeeFocus,
  required FocusNode roleFocus,
  required DateTime? endDate,
  required DateTime startDate,
  required DateFormat formatter,
  required GlobalKey<FormState> key,
}) {
  return ListView(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    children: [
      Form(
        key: key,
        child: Column(
          children: [
            TextFormField(
              cursorHeight: 15,
              controller: employeeController,
              style: h4Black,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outlined,
                  color: primaryColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: grey, width: .2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: grey, width: .2),
                ),
                hintText: "Employee name",
                hintStyle: h5,
                isDense: true,
                border: InputBorder.none,
                constraints: BoxConstraints(maxHeight: 35),
              ),
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return "This field is required";
              //   } else {
              //     return null;
              //   }
              // },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: roleController,
              cursorHeight: 15,
              readOnly: true,
              style: h4Black,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.work_outline,
                  color: primaryColor,
                ),
                suffixIcon: GestureDetector(
                  onTap: onDropDown,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: primaryColor,
                    size: 30,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: grey, width: .2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: grey, width: .2),
                ),
                hintText: "Select role",
                hintStyle: h5,
                isDense: true,
                border: InputBorder.none,
                constraints: BoxConstraints(maxHeight: 35),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onStart,
            child: Container(
              height: 35,
              width: MediaQuery.of(context).size.width * .4,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey, width: .2),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  if (startDate.day == DateTime.now().day &&
                      startDate.month == DateTime.now().month &&
                      startDate.year == DateTime.now().year) ...[
                    Text("Today", style: h5),
                  ] else
                    Text(formatter.format(startDate), style: h5)
                ],
              ),
            ),
          ),
          SvgPicture.asset(
            "assets/arrow_right_vector.svg",
            color: primaryColor,
          ),
          GestureDetector(
            onTap: onEnd,
            child: Container(
              height: 35,
              width: MediaQuery.of(context).size.width * .4,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey, width: .2),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  if (endDate == null) Text("No date", style: h5),
                  if (endDate != null)
                    Text(formatter.format(endDate), style: h5)
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
