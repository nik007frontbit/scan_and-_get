import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message,
    {bool isError = false, bool isWarning = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: isError
          ? Colors.red
          : isWarning
              ? Colors.yellow
              : Colors.green,
    ),
  );
}
