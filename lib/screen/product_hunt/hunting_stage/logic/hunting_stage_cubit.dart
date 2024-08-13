import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path_package;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_and_get_images/screen/product_hunt/hunting_stage/model/message_response_model.dart';
import 'package:scan_and_get_images/screen/product_hunt/product_hunt_form/logic/product_hunt_form_cubit.dart';
import 'package:scan_and_get_images/src/core/utils/snackbar.dart';

import '../../../../src/core/utils/custom_exception.dart';
import '../../../../src/core/utils/loading_view.dart';
import 'hunting_stage_repository.dart';

part 'hunting_stage_state.dart';

//test
// class HuntingStageCubit extends Cubit<HuntingStageState> {
//   HuntingStageCubit() : super(HuntingStageInitialState());
//   bool isBox = true;
//   List huntList = [];
//
//   Map huntListIsBox = {
//     "title": 'Box',
//     "sides": [
//       {
//         "sideName": "Front Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Back Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Upper Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Lower Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Left Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Right Side",
//         "image": "",
//         "infoImage": "",
//       },
//     ]
//   };
//   Map huntListIsNotBox = {
//     "title": 'Stripe',
//     "sides": [
//       {
//         "sideName": "Front Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Back Side",
//         "image": "",
//         "infoImage": "",
//       },
//     ]
//   };
//
//   bool isStrip = true;
//   List insideBoxHuntList = [];
//   Map insideBoxHuntIsStripList = {
//     "title": 'Stripe',
//     "sides": [
//       {
//         "sideName": "Front Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Back Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Contain Image",
//         "image": "",
//         "infoImage": "",
//       },
//     ]
//   };
//   Map insideBoxHuntIsNotStripList = {
//     "title": 'Stripe',
//     "sides": [
//       {
//         "sideName": "Front Side",
//         "image": "",
//         "infoImage": "",
//       },
//       {
//         "sideName": "Back Side",
//         "image": "",
//         "infoImage": "",
//       },
//     ]
//   };
//
//   setImageList() {
//     if (isBox && isStrip) {
//       huntList.clear();
//       huntList.add(huntListIsBox);
//       huntList.add(insideBoxHuntIsStripList);
//     } else if (isBox && isStrip == false) {
//       huntList.clear();
//       huntList.add(huntListIsBox);
//       huntList.add(insideBoxHuntIsNotStripList);
//     } else if (isBox == false) {
//       huntList.clear();
//       huntList.add(huntListIsNotBox);
//     }
//     emit(HuntingStageSuccessState());
//   }
//
//   changeValueOfBox(bool value) {
//     isBox = value;
//     // setImageList();
//     emit(HuntingStageSuccessState());
//   }  changeValueOfStrip(bool value) {
//     isStrip = value;
//     // setImageList();
//     emit(HuntingStageSuccessState());
//   }
//
//   addImage({required BuildContext context, required String path}) async {
//     final ImagePicker picker = ImagePicker();
//     var picked = await picker.pickImage(source: ImageSource.camera);
//     // selectedImages.addAll(picked.map(
//     //   (e) => e.path,
//     // ));
//     if (picked != null && picked.path != "") {
//       // selectedImages.add(picked.path);
//         path = picked.path;
//         print(path);
//         // await readTextFromImage(imagePath: picked.path, context: context);
//
//     }
//     emit(HuntingStageSuccessState());
//   }
//
//   deleteImage({required BuildContext context, required String path}) async {
//     await File(path).delete();
//     path = "";
//     Navigator.pop(context);
//     emit(HuntingStageSuccessState());
//   }
//
//   submitImages({
//     required BuildContext context,
//   }) async {
//     bool isAnyMissing =
//         huntList.expand((e) => e['sides']).any((side) => side['image'] == "");
//     if (isAnyMissing) {
//       emit(HuntingStageErrorState(
//           error: "Some image is not Found Please check"));
//     } else {
//       emit(HuntingStageSuccessState());
//     }
//   }
// }

class HuntingStageCubit extends Cubit<HuntingStageState> {
  HuntingStageCubit() : super(HuntingStageInitialState());

  bool isBox = true;
  bool isStrip = true;
  bool isCartoon = true;

  List<Map<String, dynamic>> huntList = [];

  List<Map<String, String>> extraImages = [];
  final Map<String, dynamic> huntListIsBox = {
    "title": 'Box',
    "sides": [
      {
        "sideName": "Front Side",
        "image": "",
        "infoImage": "",
        "tag": "box_front_image"
      },
      {
        "sideName": "Back Side",
        "image": "",
        "infoImage": "",
        "tag": "box_back_image"
      },
      {
        "sideName": "Left Side",
        "image": "",
        "infoImage": "",
        "tag": "box_left_image"
      },
      {
        "sideName": "Right Side",
        "image": "",
        "infoImage": "",
        "tag": "box_right_image"
      },
      {
        "sideName": "Upper Side",
        "image": "",
        "infoImage": "",
        "tag": "box_top_image"
      },
      {
        "sideName": "Lower Side",
        "image": "",
        "infoImage": "",
        "tag": "box_bottom_image"
      },
    ]
  };

  final Map<String, dynamic> huntListIsNotBox = {
    "title": 'Without Box',
    "sides": [
      {
        "sideName": "Front Side",
        "image": "",
        "infoImage": "",
        "tag": "product_front_image"
      },
      {
        "sideName": "Back Side",
        "image": "",
        "infoImage": "",
        "tag": "product_back_image"
      }
    ]
  };

  final Map<String, dynamic> insideBoxHuntIsStripList = {
    "title": 'Stripe',
    "sides": [
      {
        "sideName": "Product Front Side",
        "image": "",
        "infoImage": "",
        "tag": "product_front_image"
      },
      {
        "sideName": "Product Back Side",
        "image": "",
        "infoImage": "",
        "tag": "product_back_image"
      },
      {
        "sideName": "Product Contain Image",
        "image": "",
        "infoImage": "",
        "tag": "content_image"
      }
    ]
  };

  final Map<String, dynamic> insideBoxHuntIsNotStripList = {
    "title": 'Non Stripe',
    "sides": [
      {
        "sideName": "Product Front Side",
        "image": "",
        "infoImage": "",
        "tag": "product_front_image"
      },
      {
        "sideName": "Product Back Side",
        "image": "",
        "infoImage": "",
        "tag": "product_back_image"
      },
    ]
  };
  final Map<String, dynamic> cartoonSides = {
    "title": 'Cartoon',
    "sides": [
      {
        "sideName": "Cartoon Front Side",
        "image": "",
        "infoImage": "",
        "tag": "carton_front_image"
      },
      {
        "sideName": "Cartoon Back Side",
        "image": "",
        "infoImage": "",
        "tag": "carton_back_image"
      }
    ]
  };

  void resetState() {
    isBox = true;
    isStrip = true;
    isCartoon = true;
    huntList.clear();
    extraImages.clear();
    setImageList();
    emit(HuntingStageInitialState());
  }

  void setImageList() {
    huntList.clear();
    if (isBox) {
      huntList.add(huntListIsBox);
      huntList.add(
          isStrip ? insideBoxHuntIsStripList : insideBoxHuntIsNotStripList);
    } else {
      huntList.add(huntListIsNotBox);
    }
    if (isCartoon) {
      huntList.add(cartoonSides);
    }
    emit(HuntingStageSuccessState());
  }

  void changeValueOfBox(bool value) {
    isBox = value;
    setImageList();
  }

  void changeValueOfStrip(bool value) {
    isStrip = value;
    setImageList();
  }

  void changeValueOfCartoon(bool value) {
    isCartoon = value;
    setImageList();
  }

  Future<void> addImage(
      {required BuildContext context, required String sideName}) async {
    // final ImagePicker picker = ImagePicker();
    // final picked = await picker.pickImage(source: ImageSource.camera);
    if (await Permission.camera.isGranted == false) {
      await requestCamaraPermissions();
    }
    // Show loader while requesting permissions
    var picked = await CunningDocumentScanner.getPictures(
      noOfPages: 1,
    ).onError((error, stackTrace) {
      showSnackBar(context, "Image is Not Selected... $error", isError: true);
      throw Exception("Image is Not Selected... $error");
    });
    if (picked != null && picked[0].isNotEmpty) {
      print("File Image-----${picked[0]}");
      // Find the side and update its image
      for (var list in huntList) {
        for (var side in list['sides']) {
          if (side['sideName'] == sideName) {
            File rotateImage =
                await FlutterExifRotation.rotateAndSaveImage(path: picked[0]);

            side['image'] = rotateImage.path;
            print("Rotate Image Image-----${rotateImage.path}");
            break;
          }
        }
      }
      emit(HuntingStageSuccessState());
    }
  }

  Future<void> deleteImage(
      {required BuildContext context, required String sideName}) async {
    for (var list in huntList) {
      for (var side in list['sides']) {
        if (side['sideName'] == sideName) {
          if (side['image'].isNotEmpty) {
            try {
              await File(side['image']).delete();
            } catch (e) {}
            side['image'] = "";
          }
          break;
        }
      }
    }
    Navigator.pop(context);
    emit(HuntingStageSuccessState());
  }

  Future<void> addExtraImage({required BuildContext context}) async {
    // final ImagePicker picker = ImagePicker();
    // final picked = await picker.pickImage(source: ImageSource.camera);

    if (await Permission.camera.isGranted == false) {
      await requestCamaraPermissions();
    }
    // Show loader while requesting permissions
    var picked = await CunningDocumentScanner.getPictures(
      noOfPages: 1,
    ).onError((error, stackTrace) {
      showSnackBar(context, "Image is Not Selected... $error", isError: true);
      throw Exception("Image is Not Selected... $error");
    });
    if (picked != null && picked[0].isNotEmpty) {
      File rotateImage =
          await FlutterExifRotation.rotateImage(path: picked[0]);

      extraImages.add({"image": rotateImage.path});
      emit(HuntingStageSuccessState());
    }
  }

  Future<void> deleteExtraImage(int index, BuildContext context) async {
    if (extraImages[index]['image']!.isNotEmpty) {
      await File(extraImages[index]['image']!).delete();
      extraImages.removeAt(index);
      Navigator.pop(context);
      emit(HuntingStageSuccessState());
    }
  }

  Future<void> submitImages(
      {required BuildContext context,
      required Map<String, dynamic> map}) async {
    bool isAnyMissing =
        huntList.expand((e) => e['sides']).any((side) => side['image'] == "");
    if (isAnyMissing) {
      emit(HuntingStageErrorState(
          error: "Some images are missing. Please check."));
    } else {
      Map<String, Map<String, String>> tagMap = {};
      for (var list in huntList) {
        for (var side in list['sides']) {
          map.addAll({
            side['tag']: await MultipartFile.fromFile(
              side['image']!,
              filename: path_package.basename(side['image']),
            ),
          });
          // tagMap[side['tag']] = side;
        }
      }
      if (extraImages.length > 0) {
        for (int i = 0; i < extraImages.length; i++) {
          map.addAll({
            'other_images_${i + 1}': await MultipartFile.fromFile(
                extraImages[i]['image']!,
                filename: path_package.basename(extraImages[i]['image']!)),
          });
          // tagMap['other_images_${i+1}']=extraImages[i]['image'];
        }
      }

      map.addAll({
        'product_packing': isBox ? 'box' : "other",
        'inside_box': isBox && isStrip ? 'strip' : "",
        'carton_available': isCartoon ? "yes" : "no",
        'other_images_count': extraImages.length.toString(),
        'accesskey': '704df5854e6011ef9a5dd49390325d4e'
      });
      try {
        showLoadingView(context);
        MessageResponseModel messageResponseModel =
            await HuntingStageRepository().submitImages(map);
        if (messageResponseModel.statusCode == 1) {
          showSnackBar(
            context,
            messageResponseModel.message,
          );

          BlocProvider.of<ProductHuntFormCubit>(context).medicineSearchCancel();
          BlocProvider.of<ProductHuntFormCubit>(context)
              .historyAddAndRefresh(map['medicine_name']);
          Navigator.pop(context);

          final cacheDir = await getTemporaryDirectory();

          if (cacheDir.existsSync()) {
            cacheDir.deleteSync(recursive: true);
          }

          // for (var list in huntList) {
          //   for (var side in list['sides']) {
          //     await File(side['image']).delete();
          //     // tagMap[side['tag']] = side;
          //   }
          // }
          // if (extraImages.length > 0) {
          //   for (int i = 0; i < extraImages.length; i++) {
          //     await File(extraImages[i]['image']!).delete();
          //     // tagMap['other_images_${i+1}']=extraImages[i]['image'];
          //   }
          // }
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
        emit(HuntingStageSuccessState());
      } on CustomException catch (e) {
        hideLoadingView(context);
        if (!isClosed) {
          emit(HuntingStageErrorState(error: e.cause));
        }
      }
    }
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
