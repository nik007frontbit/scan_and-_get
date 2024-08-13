import 'package:flutter/material.dart';

class TextFieldView extends StatelessWidget {
  String title;
  TextEditingController textEditingController;

  TextFieldView(
      {Key? key, required this.title, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            labelText: title,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
              15,
            ))),
      ),
    );
  }
}
