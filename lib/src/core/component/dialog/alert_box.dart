import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  final String message;

  const AlertBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Extracted Text'),
      content: SingleChildScrollView(
        child: Text(
          message.toString().replaceAll(
                "],",
                "],\n\n",
              ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class AlertBoxDelete extends StatelessWidget {
  final Function() onTap;

  const AlertBoxDelete({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Extracted Text'),
      content: Text("Are you Sure You want to delete this image?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text('Sure'),
        ),
      ],
    );
  }
}
