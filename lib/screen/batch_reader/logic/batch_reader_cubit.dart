import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path_package;
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_and_get_images/screen/batch_reader/logic/batch_reader_repository.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/address_search_model_entity.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/batch_reader_model_entity.dart';
import 'package:scan_and_get_images/src/core/model/batch_reader.dart';
import 'package:scan_and_get_images/src/core/utils/show_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../src/core/utils/custom_exception.dart';
import '../../../src/core/utils/loading_view.dart';

part 'batch_reader_state.dart';

class BatchReaderCubit extends Cubit<BatchReaderState> {
  BatchReaderCubit() : super(BatchReaderInitialState());
  final BatchReaderRepository batchReaderRepository = BatchReaderRepository();
  List<Map<String, dynamic>> selectedImages = [];
  bool isDrug = true;
  String searchedMedicineName = "";
  int? searchedMedicineId;
  TextEditingController medicineSearchController = TextEditingController();

  checkDrugValue() async {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text("Select Product Type"),
    //     actions: [
    //       ElevatedButton(
    //           onPressed: () => changeValueOfDrug(true),
    //           child: Text("Drug")),
    //       ElevatedButton(
    //           onPressed: () =>changeValueOfDrug(false),
    //           child: Text("Fmcg"))
    //     ],
    //   ),
    // );
    await Future.delayed(Duration(microseconds: 1));
    print("change State");
    emit(BatchReaderInitial());
  }

  changeValueOfDrug(value) {
    isDrug = value;
    emit(BatchReaderSuccessState());
  }

  deleteImageFromList({
    required element,
    required BuildContext context,
  }) async {
    // await File(selectedImages[index]['image']!).delete();
    selectedImages.remove(element);
    Navigator.of(context).pop();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.setStringList(
    //     'selectedImages',
    //     selectedImages
    //         .map(
    //           (e) => e['image']!,
    //         )
    //         .toList());
    emit(BatchReaderSuccessState());
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
    emit(BatchReaderSuccessState());
  }

  medicineSearchSelect(AddressSearchModelDataResult addressSearchModel) {
    searchedMedicineName = addressSearchModel.medicineName;
    searchedMedicineId = addressSearchModel.medicineId;
    emit(BatchReaderSuccessState());
  }

  medicineSearchCancel() {
    searchedMedicineName = "";
    searchedMedicineId = null;
    medicineSearchController.clear();
    emit(BatchReaderSuccessState());
  }

  addImageFromCamara({required BuildContext context}) async {
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
      File rotateImage =
          await FlutterExifRotation.rotateImage(path: picked.first);

      await readTextFromImage(imagePath: rotateImage.path, context: context);

      // selectedImages.addAll(picked);
    }

    emit(BatchReaderSuccessState());
  }

  Future<void> readTextFromImage(
      {required String imagePath, required BuildContext context}) async {
    // // showSnackBar(context, "Wait for api response");
    // final inputImage = InputImage.fromFile(File(imagePath));
    // final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    // final RecognizedText recognizedText =
    //     await textRecognizer.processImage(inputImage);
    // print("object");
    //
    // List<String> patterns = [
    //   'nutritional',
    //   'information',
    //   'content',
    //   'contains',
    //   'each',
    //   'contain',
    //   'contains',
    //   'unit',
    //   'serving',
    //   'nutrition',
    //   'info',
    //   'per',
    //   'serve',
    //   'approx',
    //   'value',
    //   'acid',
    //   'acids',
    //   'drops',
    //   'drop',
    //   'use',
    //   'uses',
    //   'vitamin',
    //   'vitamins',
    //   'tablet',
    //   'tablets',
    //   'mineral',
    //   'minerals',
    //   "dosage",
    //   "medication",
    //   "prescription",
    //   "dosage",
    //   "form",
    //   "administration",
    //   "prescribed",
    //   "pill",
    //   "capsule",
    //   "drug",
    //   "drugs",
    //   "prescribed",
    //   "amount",
    //   "therapeutic",
    //   "indication",
    //   "contraindication",
    //   "side effects",
    //   "adverse",
    //   "effects",
    //   "precautions",
    //   "interactions",
    //   "storage",
    //   "expiry date",
    //   "prescription",
    //   "label",
    //   "pharmacist",
    //   "pharmacy",
    //   "refill",
    //   "patient",
    //   "information",
    //   "dosage",
    //   "instructions",
    //   "dose",
    //   "regimen"
    // ];
    // // print(recognizedText.text.contains(patterns.map((e) => e,)));
    // // String text = recognizedText.text;
    // bool isMedicine = patterns.any((pattern) =>
    //     recognizedText.text.toLowerCase().contains(pattern.toLowerCase()));
    // String text = "";
    //
    // // print(text);
    // textRecognizer.close();
    await dioPostRequest(path: imagePath, context: context);
  }

  BatchReaderModel? batchReaderModel;

  Future<void> dioPostRequest(
      {required String path, required BuildContext context}) async {
    showLogs(path);
    showLoadingView(context);

    // currntly working
    // var formData = FormData.fromMap({
    //   'image': await MultipartFile.fromFile(path, filename: ''),
    // });
    var map = {
      'image': await MultipartFile.fromFile(path,
          filename: path_package.basename(path)),
      'product_category': isDrug ? "drug" : "fmcg",
      'accesskey': "704df5854e6011ef9a5dd49390325d4e",
    };
    emit(BatchReaderSuccessState());
    try {
      BatchReaderModelData? batchReaderModelData =
          await batchReaderRepository.sendBatchProduct(map);
      selectedImages.add({'image': path, 'data': batchReaderModelData!});
      hideLoadingView(context);
    } on CustomException catch (e) {
      hideLoadingView(context);
      if (!isClosed) {
        emit(BatchReaderErrorState(error: e.cause));
      }
    }

//       var dio = Dio();
//
//       var response = await dio.request(
//         'https://2e47-182-70-125-130.ngrok-free.app/other/read_batch',
//         options: Options(
//           method: 'POST',
//         ),
//         data: formData,
//       );
//
//       hideLoadingView(context);
//
//       print(response.data);
//       if (response.statusCode == 200) {
//         batchReaderModel = BatchReaderModelFromJson(json.encode(response.data));
//
//         // selectedImages.add(batchReaderModel!);
//         if (batchReaderModel!.statusCode == 1) {
//           showSnackBar(
//             context,
//             batchReaderModel!.statusMessage,
//           );
// /*back(18434): Set 'android:enableOnBackInvokedCallback="true"' in the application manifest.
// I/flutter (18434): {status_code: 1, status_message: Data fetched successfully, data: {batch: XT1023001, exp: 2025-02, mrp: 5.56}}*/
//           // selectedImages.add({
//           //   'image': path,
//           //   "batch": response.data['data']["batch"],
//           //   "exp": response.data['data']["exp"],
//           //   "mrp": response.data['data']["mrp"].toString()
//           // });
//           // await File(path).delete();
//           emit(BatchReaderSuccessState());
//           // showDialog(
//           //   context: context,
//           //   builder: (context) {
//           //     return AlertBox(
//           //         message: batchReaderModel!.data.toString().replaceAll(
//           //               "],",
//           //               "],\n\n",
//           //             ));
//           //   },
//           // );
//           // Process the extracted text as required (e.g., display in a dialog).
//           return batchReaderModel!.statusMessage;
//         } else {
//           showSnackBar(
//             context,
//             response.data["status_message"] ?? "Something went wrong",
//             isWarning: true,
//           );
//
//           showLogs(response.data.toString());
//           return response.data["status_message"] ?? "Something went wrong";
//         }
//
//         // return(json.encode(response.data));
//         return response.toString();
//       } else {
//         showSnackBar(
//           context,
//           response.statusMessage ?? "Something went wrong",
//           isWarning: true,
//         );
//         showLogs(response.statusMessage.toString());
//
//         return response.statusMessage ?? "Something went wrong";
//       }
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
