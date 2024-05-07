import 'package:flutter/material.dart';

class Msg {
  static const errorMsg = 'Something went wrofinalng';
}

// // make snackBarKey and assign in
// final GlobalKey<ScaffoldMessengerState> snackbarKey =
//     GlobalKey<ScaffoldMessengerState>();

// void snackBarMsessege(String message, {Color? color}) {
//   final snackBar = SnackBar(
//     content: Text(message),
//     duration: const Duration(seconds: 3),
//     backgroundColor: color,
//   );
//   snackbarKey.currentState?.showSnackBar(snackBar);
// }



final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void ShowSnackBarMsg(String message, {Color? color}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}