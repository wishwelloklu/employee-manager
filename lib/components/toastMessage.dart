import 'package:flutter/material.dart';

void scaffoldToast({
  required BuildContext context,
  required String message,
  Duration? duration,
  void Function()? onTap,
  String? actionLabel,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: duration ?? Duration(seconds: 3),
    action: onTap != null
        ? SnackBarAction(label: actionLabel ?? "Undo", onPressed: onTap)
        : null,
  ));
}
