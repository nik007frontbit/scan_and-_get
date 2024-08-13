import 'package:flutter/material.dart';

class DropdownFieldView extends StatefulWidget {
  String? currentValue;
  String? label;
  List<String> medicineType;

  DropdownFieldView(
      {Key? key,
      required this.label,
      required this.currentValue,
      required this.medicineType})
      : super(key: key);

  @override
  State<DropdownFieldView> createState() => _DropdownButtonViewState();
}

class _DropdownButtonViewState extends State<DropdownFieldView> {
  @override
  Widget build(BuildContext context) {
    return // Dropdown field for selecting medicine type
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: widget.currentValue,
        // hint: Text('Select Medicine Type'),
        onChanged: (String? newValue) {
          setState(() {
            widget.currentValue = newValue!;
          });
        },
        items: widget.medicineType.map((String medicineType) {
          return DropdownMenuItem<String>(
            value: medicineType,
            child: Text(medicineType),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
