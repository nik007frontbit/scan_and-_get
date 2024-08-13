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
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.file(
              File(imagePath),
            ),
          ),
          Center(child: Text(batch!=""?batch:"xxxxx"))
        ],
      ),
    );
  }
}
