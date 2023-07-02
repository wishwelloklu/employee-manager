import 'package:employee_manager/components/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/src/intl/date_format.dart';

import '../../../model/previousEmployeesModel .dart';

Widget previousEmployeesWidget({
  required BuildContext context,
  required PreviousEmployeeModelList? list,
  required DateFormat formatter,
}) {
  return  Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              color: Color(0xFFF2F2F2),
              child: Text(
                "Previous employees",
                style: h3Primary,
              ),
            ),
            for (var index = 0;
                index < list!.previousEmployeeModelList!.length;
                index++)
              ListTile(
                title: Text("${list.previousEmployeeModelList![index].name}",
                    style: h3Black),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(list.previousEmployeeModelList![index].role!,
                        style: h4Grey),
                    Text(
                        "From ${formatter.format(DateTime.parse(list.previousEmployeeModelList![index].startDate!))}",
                        style: h4Grey),
                  ],
                ),
              ),
            Divider(
              thickness: .5,
              height: 0,
            ),
          ],
        )
     ;
}
