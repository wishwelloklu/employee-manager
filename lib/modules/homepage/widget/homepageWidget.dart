import 'package:employee_manager/components/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/src/intl/date_format.dart';

import '../../../components/colors.dart';
import '../../../model/employeeModel.dart';

Widget homepageWidget({
  required BuildContext context,
  required void Function( int id) onSlideToDelete,
  required void Function( EmployeeModel model) onEmplopyee,
  required EmployeeModelList? list,
  required DateFormat formatter,
}) {
  return list != null
      ? ListView.builder(
          itemCount: list.employeeModelList!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Dismissible(
                  key: ValueKey(list.employeeModelList![index]),
                  onDismissed: (direction) => onSlideToDelete( list.employeeModelList![index].id!),
                  
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    color: red,
                    child: Icon(Icons.delete),
                  ),
                  child: ListTile(
                    onTap:()=> onEmplopyee(list.employeeModelList![index]),
                    title: Text("${list.employeeModelList![index].name}",
                        style: h3Black),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(list.employeeModelList![index].role!,
                            style: h4Grey),
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
                )
              ],
            );
          })
      : Center(
          child: SvgPicture.asset("assets/empty.svg"),
        );
}
