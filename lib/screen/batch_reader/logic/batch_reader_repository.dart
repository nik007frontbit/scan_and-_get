import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:scan_and_get_images/api/http_service.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/batch_reader_model_entity.dart';
import 'package:scan_and_get_images/src/core/utils/custom_exception.dart';

class BatchReaderRepository {
  Future<BatchReaderModelData?> sendBatchProduct(Map<String,dynamic> map) async {
    var data = FormData.fromMap(map);

    try{
    Response response = await HttpService().postRequest(
      endPoint: 'other/read_batch',
      map: data,
    );

    if (response.statusCode == 200) {
      // print("${response.data['data']['mrp']}");
      // print("${response.data['data']['mrp'].runtimeType}");
      // print("{response.data['mrp']}");
      final resp = $BatchReaderModelEntityFromJson(response.data);
      if (resp.statusCode == 1) {
        return resp.data;
      } else {
        throw CustomException(resp.statusMessage ?? "Something Went Wrong!!");
      }
    }
/*back(18434): Set 'android:enableOnBackInvokedCallback="true"' in the application manifest.
I/flutter (18434): {status_code: 1, status_message: Data fetched successfully, data: {batch: XT1023001, exp: 2025-02, mrp: 5.56}}*/
      // selectedImages.add({
      //   'image': path,
      //   "batch": response.data['data']["batch"],
      //   "exp": response.data['data']["exp"],
      //   "mrp": response.data['data']["mrp"].toString()
      // });
      // var resp = $InitEntityFromJson(response.data);
      // if (resp.statusCode == "1") {
      //   //set required records in preference
      //   await SharedPref.setString(PrefKey.initDataResp, resp.data.toString());
      //   GlobalVariables.isComingFromEvitalPatientApp =
      //       (resp.data?.isEvitalPatientApp ?? false);
      //   Global.isRxToGxEnabled =
      //       equalsIgnoreCase(resp.data?.settingResults?.isRxToGxEnabled, "yes");
      //
      //   await SharedPref.setBool(
      //       PrefKey.isPrescriptionRequired,
      //       equalsIgnoreCase(
      //           resp.data?.settingResults?.isPrescriptionRequired, "yes"));
      //
      //   if (!(resp.data?.settingResults?.whitelabelPrimaryColorTheme ?? "")
      //           .isNullOrEmpty() &&
      //       !equalsIgnoreCase(flavorConfig?.flavor, "evital")) {
      //     Color hexToColor(String code) {
      //       return Color(
      //           int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
      //     }
      //
      //     primaryColor = hexToColor(
      //         resp.data?.settingResults?.whitelabelPrimaryColorTheme ??
      //             "#000000");
      //   }
      //   return resp.statusCode;
      // } else {
      //   throw CustomException(resp.statusMessage ?? "");
      // }
    }on CustomException catch (e) {
      log("message ${e}");
      throw CustomException(e.cause?? "");
    }
  }
}
