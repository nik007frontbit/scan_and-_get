import 'package:dio/dio.dart';
import 'package:scan_and_get_images/api/http_service.dart';
import 'package:scan_and_get_images/screen/product_hunt/hunting_stage/model/message_response_model.dart';

import '../../../../src/core/utils/custom_exception.dart';

class HuntingStageRepository {
  Future<MessageResponseModel> submitImages(Map<String, dynamic> map) async {
    var data = FormData.fromMap(map);
    try {
      var response = await HttpService().postRequest(
        endPoint: 'other/collect_data',
        map: data,
      );

      if (response.statusCode == 200) {
        var data = response.data;

        return MessageResponseModel(
            statusCode: int.parse(
              data['status_code'].toString(),
            ),
            message: data['status_message']);
      } else {
        var data = response.data;
        return MessageResponseModel(
            statusCode: -1, message: data['status_message']);
      }
    } on CustomException catch (e) {
      throw CustomException(e.cause ?? "");
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
