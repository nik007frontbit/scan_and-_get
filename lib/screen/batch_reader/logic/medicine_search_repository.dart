import 'package:dio/dio.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/address_search_model_entity.dart';

import '../../../api/http_service.dart';
import '../model/medicine_search_entity.dart';

class MedicineSearchRepository {
  Future<List<AddressSearchModelDataResult>> callMedicineSearchApi(
      Map<String, String> map) async {
    map.addAll({
      "chemist_id": "48935",
      "accesstoken": "jo6vp61lzjiw919v",
      "device_id": "9b0ada0e-9af4-4afa-b7b6-06f0101f9b7f",
      // "app_version": "1",
      // "os": "android",
      "apikey": "R08mGEm4550Bi69AHobdH9E4QY02f1N7"
    });
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

  Future<List<MedicineSearchDataMedicinesResult>>
      callMedicineSearchApiForBarcode(Map<String, String> map) async {
    map.addAll({
      "chemist_id": "48935",
      "accesstoken": "jo6vp61lzjiw919v",
      "device_id": "905fa703-7970-4f75-8e0f-f996bb6d4f67",
      "search_source": "master_search",
      "category": "medicine",
      "fcmtoken": "",
      "app_version": "",
      "os": "android"
    });
    Response response;
    try {
      //https://api.evitalrx.in/v1/whitelabel/medicines/search
      response = await HttpService(
              baseUrl: 'https://www.evitalrx.in:4000/v3/dashboard/')
          .postRequest(endPoint: "master_search", map: map);
      if (response.statusCode == 200) {
        var resp = $MedicineSearchEntityFromJson(response.data);
        if (resp.statusCode == "1") {
          List<MedicineSearchDataMedicinesResult> mList = [];
          mList.addAll(resp.data!.medicines!.result ?? []);
          print(mList);
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
