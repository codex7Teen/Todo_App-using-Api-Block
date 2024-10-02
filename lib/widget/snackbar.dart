
import 'package:flutter/material.dart';


//! Universal snackbar
void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
  duration: Duration(seconds: 2),
  );

  // Show the snackbar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
