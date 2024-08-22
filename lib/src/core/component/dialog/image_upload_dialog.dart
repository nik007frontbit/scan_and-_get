import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_and_get_images/src/core/utils/snackbar.dart';

import '../../utils/permissions/camara_permission.dart';

imageUploadDialog({
  required BuildContext context,
  required Function({required String imagePath, required BuildContext context})
      onImageSelect,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () async {
                  if (await Permission.camera.isGranted == false) {
                    await requestCamaraPermissions();
                  }
                  // Show loader while requesting permissions
                  var picked = await CunningDocumentScanner.getPictures(
                    noOfPages: 1,
                  ).onError((error, stackTrace) {
                    throw Exception("Image is Not Selected... $error");
                  });
                  if (picked!.isNotEmpty && picked.first != null) {
                    File rotateImage = await FlutterExifRotation.rotateImage(
                        path: picked.first);

                    onImageSelect(
                      imagePath: rotateImage.path,
                      context: context,
                    );
                    Navigator.pop(context, rotateImage.path);
                    // selectedImages.addAll(picked);
                  } else {
                    showSnackBar(
                      context,
                      "Image not selected",
                      isError: true,
                    );
                    Navigator.pop(context, "");
                  }
                },
                icon: Icon(
                  Icons.camera,
                )),
            IconButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  var picked =
                      await picker.pickImage(source: ImageSource.gallery);
                  // selectedImages.addAll(picked.map(
                  //   (e) => e.path,
                  // ));
                  if (picked != null && picked.path != "") {
                    File rotateImage = await FlutterExifRotation.rotateImage(
                        path: picked.path);

                    onImageSelect(
                      imagePath: rotateImage.path,
                      context: context,
                    );
                    Navigator.pop(context, rotateImage.path);
                    // selectedImages.addAll(picked);
                  } else {
                    showSnackBar(
                      context,
                      "Image not selected",
                      isError: true,
                    );
                    Navigator.pop(context, "");
                  }
                },
                icon: Icon(
                  Icons.image,
                )),
          ],
        ),
      );
    },
  );
}
