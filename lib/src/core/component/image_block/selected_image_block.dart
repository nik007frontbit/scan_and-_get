import 'dart:io';

import 'package:flutter/material.dart';

class SelectedImageBlock extends StatelessWidget {
  String imagePath;
  String batch;

  SelectedImageBlock({super.key, required this.imagePath,this.batch=""});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: Colors.deepPurple,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(batch)
        ],
      ),
    );
  }
}
