import 'package:flutter/material.dart';

showLoadingView(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Material(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

hideLoadingView(BuildContext context) {
  Navigator.pop(context);
}
