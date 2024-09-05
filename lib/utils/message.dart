import 'package:flutter/material.dart';
import 'package:rush/utils/navigation.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void ShowSnackBarMsg(String message, {Color? color}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}



// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showAlertDialog(String title, String message, {VoidCallback? onOkPressed, VoidCallback? onCancelPressed}) {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
            if (onCancelPressed != null) {
              onCancelPressed();
            }
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
            if (onOkPressed != null) {
              onOkPressed();
            }
          },
          child: Text("Login"),
        ),
      ],
    ),
  );
}

