import 'package:employee_manager/components/textStyle.dart';
import 'package:flutter/material.dart';

Widget homepageWidget({
  required BuildContext context,
}) {
  return ListView(
    children: [
      for (var i = 0; i < 15; i++) ...[
        ListTile(
          onTap: () {},
          title: Text("Employee name", style: h3BlackBold),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Post", style: h4Grey),
              Text("Starting date", style: h4Grey),
            ],
          ),
        ),
        Divider(
          thickness: .5,
        )
      ]
    ],
  );
}
