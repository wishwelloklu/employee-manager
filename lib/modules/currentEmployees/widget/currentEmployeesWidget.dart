import 'package:employee_manager/components/textStyle.dart';
import 'package:employee_manager/model/employeesModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/src/intl/date_format.dart';

import '../../../components/colors.dart';

Widget currentEmployeesWidget({
  required BuildContext context,
  required void Function(int id) onSlideToDelete,
  required void Function(EmployeeModel model) onEmplopyee,
  required EmployeeModelList? list,
  required DateFormat formatter,
}) {
  return ListView(
    children: [
      for (var index = 0; index < list!.employeeModelList!.length; index++)
        if (list.employeeModelList![index].deleted == 0) ...[
          Dismissible(
            key: ValueKey(list.employeeModelList![index]),
            onDismissed: (direction) =>
                onSlideToDelete(list.employeeModelList![index].id!),
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              color: red,
              child: Icon(
                FontAwesomeIcons.trashCan,
                color: white,
              ),
            ),
            child: ListTile(
              onTap: () => onEmplopyee(list.employeeModelList![index]),
              title: Text("${list.employeeModelList![index].name}",
                  style: h3Black),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(list.employeeModelList![index].role!, style: h4Grey),
                  Text(
                      "From ${formatter.format(DateTime.parse(list.employeeModelList![index].startDate!))}",
                      style: h4Grey),
                ],
              ),
            ),
          ),
          Divider(
            thickness: .5,
            height: 0,
          ),
        ],
    ],
  );
}
