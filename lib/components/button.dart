import 'package:employee_manager/components/colors.dart';
import 'package:employee_manager/components/textStyle.dart';
import 'package:flutter/material.dart';

Widget button({
  @required void Function()? onPressed,
  void Function()? onLongPressed,
  @required String? text,
  @required Color? color,
  Color textColor = white,
  bool colorFill = true,
  @required BuildContext? context,
  double divideWidth = 1.0,
  bool useWidth = true,
  double buttonRadius = 5,
  double height = 40,
  double elevation = .0,
  Color backgroundcolor = white,
  TextStyle? textStyle,
  Widget? leadingIcon,
  bool showBorder = true,
  EdgeInsetsGeometry? padding,
  bool centerItems = false,
  BorderRadiusGeometry? borderRadiusGeometry,
  Widget? postFixIcon,
  Widget? icon,
}) {
  return SizedBox(
    width: useWidth ? MediaQuery.of(context!).size.width * divideWidth : null,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        elevation: elevation,
        foregroundColor: textColor,
        backgroundColor: colorFill ? color : backgroundcolor,
        shape: showBorder
            ? RoundedRectangleBorder(
                borderRadius:
                    borderRadiusGeometry ?? BorderRadius.circular(buttonRadius),
              )
            : null,
        textStyle: textStyle ?? h4WhiteBold,
      ),
      child: leadingIcon == null && postFixIcon == null
          ? Text("$text", textAlign: TextAlign.center)
          : Row(
              mainAxisAlignment: centerItems
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (leadingIcon != null) leadingIcon,
                const SizedBox(width: 10),
                Text("$text"),
                if (postFixIcon != null) postFixIcon,
              ],
            ),
    ),
  );
}
