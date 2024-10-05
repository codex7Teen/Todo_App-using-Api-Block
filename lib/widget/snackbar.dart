import 'package:flutter/material.dart';

//! My Universal snackbar
void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message, style: const TextStyle(fontWeight: FontWeight.w500)),
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating, // Makes the snackbar float
    margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
  );

  // Show the snackbar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}