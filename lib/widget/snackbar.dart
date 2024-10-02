
import 'package:flutter/material.dart';


//! Universal snackbar
void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message, style: TextStyle(fontWeight: FontWeight.w500)),
  duration: Duration(seconds: 2),
  behavior: SnackBarBehavior.floating, // Makes the snackbar float
    margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
    
  );

  // Show the snackbar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
