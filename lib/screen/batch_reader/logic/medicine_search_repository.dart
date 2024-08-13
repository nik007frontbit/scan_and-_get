import 'package:dio/dio.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/address_search_model_entity.dart';

import '../../../api/http_service.dart';

class MedicineSearchRepository {
  Future<List<AddressSearchModelDataResult>> callMedicineSearchApi(
      Map<String, String> map) async {
    Response response;
    try {
      //https://api.evitalrx.in/v1/whitelabel/medicines/search

      response = await HttpService(
              baseUrl: 'https://search.evitalrx.in:4000/v1/evitalrx/')
          .postRequest(endPoint: "medicines/search", map: map);
      if (response.statusCode == 200) {
        var resp = $AddressSearchModelEntityFromJson(response.data);
        if (resp.statusCode == "1") {
          List<AddressSearchModelDataResult> mList = [];
          mList.addAll(resp.data.result ?? []);
          return mList;
        } else {
          throw Exception(resp.statusMessage ?? "");
        }
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      print("object   ----$e");
    }
    return [];
  }
}
