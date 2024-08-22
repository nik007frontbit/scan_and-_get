import 'package:dio/dio.dart';

import '../../../api/http_service.dart';
import '../../../src/core/utils/custom_exception.dart';
import '../../product_hunt/hunting_stage/model/message_response_model.dart';

class NutritionalRepository{
  Future<MessageResponseModel> submitImage(Map<String, dynamic> map) async {
    var data = FormData.fromMap(map);
    try {
      var response = await HttpService().postRequest(
        endPoint: 'other/get_table_of_content',
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