import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path_package;
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_and_get_images/src/core/model/nutraceuticals_model.dart';
import 'package:scan_and_get_images/src/core/utils/loading_view.dart';
import 'package:scan_and_get_images/src/core/utils/show_logs.dart';
import 'package:scan_and_get_images/src/core/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../src/core/utils/custom_exception.dart';
import '../../batch_reader/model/address_search_model_entity.dart';
import '../../batch_reader/model/medicine_search_entity.dart';
import '../../product_hunt/hunting_stage/model/message_response_model.dart';
import 'nutritional_repository.dart';

part 'nutritional_state.dart';

class NutritionalCubit extends Cubit<NutritionalState> {
  NutritionalCubit() : super(NutritionalInitialState());
  List<String> selectedImages = [];
  List selectedImagesWithName = [];
  String? medicineId;
  TextEditingController medicineSearchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final List<String> medicineTypes = ["drug", "fmcg", "nutraceutical"];

  // Track the selected medicine type
  String? selectedMedicineType;
  String? selectedDosageType;

  medicineSearchSelect(AddressSearchModelDataResult addressSearchModel) {
    emit(NutritionalSuccessState());
    nameController.text = addressSearchModel.medicineName;
    medicineSearchController.text = addressSearchModel.medicineName;
    selectedMedicineType = addressSearchModel.medicineType;
    medicineId = addressSearchModel.medicineId.toString();
    emit(NutritionalSuccessState());
  }

  medicineSearchSelectBarcode(MedicineSearchDataMedicinesResult addressSearchModel) {
    emit(NutritionalSuccessState());
    nameController.text = addressSearchModel.medicineName!;
    medicineSearchController.text = addressSearchModel.medicineName!;
    selectedMedicineType = addressSearchModel.medicineType;
    medicineId = addressSearchModel.medicineId.toString();
    emit(NutritionalSuccessState());
  }

  medicineSearchCancel() {
    emit(NutritionalLoadingState());
    selectedImages = [];
    nameController.text = "";
    medicineSearchController.text = "";
    selectedMedicineType = null;
    medicineId = null;
    emit(NutritionalSuccessState());
  }

  initLocalList() async {
    // Obtain shared preferences.
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // selectedImages = prefs.getStringList('selectedImages') ?? [];
    // emit(NutritionalSuccessState());
  }

  deleteImageFromList({
    required int index,
    required BuildContext context,
  }) async {
    await File(selectedImages[index]).delete();
    selectedImages.removeAt(index);
    Navigator.of(context).pop();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList('selectedImages', selectedImages);
    emit(NutritionalSuccessState());
  }

  addImageFromGallery({required BuildContext context}) async {
    final ImagePicker picker = ImagePicker();
    var picked = await picker.pickImage(source: ImageSource.gallery);
    // selectedImages.addAll(picked.map(
    //   (e) => e.path,
    // ));
    if (picked != null && picked.path != "") {
      // selectedImages.add(picked.path);
      if (context.mounted) {
        await readTextFromImage(imagePath: picked.path, context: context);
      }
    }
    emit(NutritionalSuccessState());
  }

  addImageFromCamara({required BuildContext context}) async {
    if (await Permission.camera.isGranted == false) {
      await requestCamaraPermissions();
    }
    // Show loader while requesting permissions
    var picked = await CunningDocumentScanner.getPictures(noOfPages: 1)
        .onError((error, stackTrace) {
      throw Exception("Image is Not Selected... $error");
    });
    if (picked!.isNotEmpty && picked.first != null) {
      if (context.mounted) {
        await readTextFromImage(imagePath: picked.first, context: context);
      }
      // selectedImages.addAll(picked);
    }

    emit(NutritionalSuccessState());
  }

  Future<void> readTextFromImage(
      {required String imagePath, required BuildContext context}) async {
    // showSnackBar(context, "Wait for api response");
    // final inputImage = InputImage.fromFile(File(imagePath));
    // final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    // final RecognizedText recognizedText =
    //     await textRecognizer.processImage(inputImage);

    //
    // List<List<String>> response = [];
    // for (var i in recognizedText.blocks) {
    //   print("list");
    //   List<String> cureent = [];
    //   for (var j in i.lines) {
    //     cureent.add(j.text);
    //     print("Here is the text:-----" + j.text);
    //   }
    //   response.add(cureent);
    // }

    List<String> patterns = [
      'nutritional',
      'information',
      'content',
      'each',
      'contain',
      'contains',
      'unit',
      'serving',
      'nutrition',
      'nutritions',
      'info',
      'per',
      'serve',
      'approx',
      'value'
    ];
    // print(recognizedText.text.contains(patterns.map((e) => e,)));
    // String text = recognizedText.text;
    // bool isMedicine = patterns.any((pattern) =>
    //     recognizedText.text.toLowerCase().contains(pattern.toLowerCase()));
    // String text = "";

    // print(text);
    // textRecognizer.close();
    // if (isMedicine) {
    //   if (context.mounted) {
    //     text =
    await dioPostRequest(path: imagePath, context: context);
    //   }
    // } else {
    //   showSnackBar(
    //     context,
    //     "image not capable for nutraceutical",
    //     isError: true,
    //   );
    // }
  }

  NutraceuticalModel? nutraceuticalModel;

  Future<void> dioPostRequest(
      {required String path, required BuildContext context}) async {
    showLogs(path);
    try {
      showLoadingView(context);
      MessageResponseModel messageResponseModel =
          await NutritionalRepository().submitImage({
        "medicine_id": medicineId,
        'image': await MultipartFile.fromFile(path,
            filename: path_package.basename(path)),
        'accesskey': "704df5854e6011ef9a5dd49390325d4e",
      });
      if (messageResponseModel.statusCode == 1) {
        showSnackBar(
          context,
          messageResponseModel.message,
        );

        // selectedImages.add(path);
        selectedImagesWithName
            .add({'image': path, "name": nameController.text});
        // // Obtain shared preferences.
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        //
        // prefs.setStringList('selectedImages', selectedImages);
        emit(NutritionalSuccessState());
      } else if (messageResponseModel.statusCode == 0) {
        showSnackBar(context, messageResponseModel.message, isWarning: true);
      } else {
        showSnackBar(
          context,
          messageResponseModel.message,
          isError: true,
        );
      }
      hideLoadingView(context);
      emit(NutritionalSuccessState());
    } on CustomException catch (e) {
      hideLoadingView(context);
      if (!isClosed) {
        emit(NutritionalErrorState(error: e.cause));
      }
    }
    // showLoadingView(context);
    // try {
    //   // currntly working
    //   // var formData = FormData.fromMap({
    //   //   'image': await MultipartFile.fromFile(path, filename: ''),
    //   // });
    //   var formData = FormData.fromMap({
    //     "medicine_id": medicineId,
    //     'image': await MultipartFile.fromFile(path,
    //         filename: path_package.basename(path)),
    //     'accesskey': "704df5854e6011ef9a5dd49390325d4e",
    //   });
    //   var dio = Dio();
    //
    //   var response = await dio.request(
    //     'https://pythondev.evitalrx.in:3050/other/get_table_of_content',
    //     options: Options(
    //       method: 'POST',
    //     ),
    //     data: formData,
    //   );
    //
    //   hideLoadingView(context);
    //
    //   if (response.statusCode == 200) {
    //     nutraceuticalModel =
    //         nutraceuticalModelFromJson(json.encode(response.data));
    //
    //     if (nutraceuticalModel!.statusCode == 1) {
    //       showSnackBar(
    //         context,
    //         nutraceuticalModel!.statusMessage,
    //       );
    //
    //       selectedImages.add(path);
    //       // Obtain shared preferences.
    //       final SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    //       prefs.setStringList('selectedImages', selectedImages);
    //       emit(NutritionalSuccessState());
    //       // showDialog(
    //       //   context: context,
    //       //   builder: (context) {
    //       //     return AlertBox(
    //       //         message: nutraceuticalModel!.data.toString().replaceAll(
    //       //               "],",
    //       //               "],\n\n",
    //       //             ));
    //       //   },
    //       // );
    //       // Process the extracted text as required (e.g., display in a dialog).
    //       return nutraceuticalModel!.statusMessage;
    //     } else {
    //       showSnackBar(
    //         context,
    //         response.data["status_message"] ?? "Something went wrong",
    //         isWarning: true,
    //       );
    //
    //       showLogs(response.data);
    //       return response.data["status_message"] ?? "Something went wrong";
    //     }
    //
    //     // return(json.encode(response.data));
    //     return response.toString();
    //   } else {
    //     showSnackBar(
    //       context,
    //       response.statusMessage ?? "Something went wrong",
    //       isWarning: true,
    //     );
    //     showLogs(response.statusMessage.toString());
    //
    //     return response.statusMessage ?? "Something went wrong";
    //   }
    // } on DioException catch (e) {
    //   hideLoadingView(context);
    //   showLogs(e.toString());
    //   showSnackBar(
    //     context,
    //     e.message ?? "Something went wrong",
    //     isError: true,
    //   );
    //   return e.toString();
    // }
  }

  Future<void> requestCamaraPermissions() async {
    var cameraStatus = await Permission.camera.status;

    switch (cameraStatus) {
      case PermissionStatus.granted:
        // Permission is already granted, proceed with your logic
        break;
      case PermissionStatus.denied:
        // Permission is denied, request it again
        await Permission.camera.request();
        //await requestCamaraPermissions(); // Recursive call
        break;
      default:
        await openAppSettings();
        break;
    }
  }
}
