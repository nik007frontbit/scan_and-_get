import 'dart:io';

import 'package:flutter/material.dart';

class BatchReaderImageBlock extends StatelessWidget {
  String image;
  String batch;
  String exp;
  String mrp;

  BatchReaderImageBlock({
    Key? key,
    required this.image,
    required this.batch,
    required this.exp,
    required this.mrp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.deepPurple, width: 1)),
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: Image.file(
              File(image),
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Batch:$batch",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Expire:$exp",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Mrp:$mrp",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
