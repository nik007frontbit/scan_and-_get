import 'package:scan_and_get_images/generated/json/base/json_convert_content.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/batch_reader_model_entity.dart';

BatchReaderModelEntity $BatchReaderModelEntityFromJson(
    Map<String, dynamic> json) {
  final BatchReaderModelEntity batchReaderModelEntity = BatchReaderModelEntity();
  final int? statusCode = jsonConvert.convert<int>(json['status_code']);
  if (statusCode != null) {
    batchReaderModelEntity.statusCode = statusCode;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['status_message']);
  if (statusMessage != null) {
    batchReaderModelEntity.statusMessage = statusMessage;
  }
  final BatchReaderModelData? data = jsonConvert.convert<BatchReaderModelData>(
      json['data']);
  if (data != null) {
    batchReaderModelEntity.data = data;
  }
  return batchReaderModelEntity;
}

Map<String, dynamic> $BatchReaderModelEntityToJson(
    BatchReaderModelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['data'] = entity.data?.toJson();
  return data;
}

extension BatchReaderModelEntityExtension on BatchReaderModelEntity {
  BatchReaderModelEntity copyWith({
    int? statusCode,
    String? statusMessage,
    BatchReaderModelData? data,
  }) {
    return BatchReaderModelEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..data = data ?? this.data;
  }
}

BatchReaderModelData $BatchReaderModelDataFromJson(Map<String, dynamic> json) {
  final BatchReaderModelData batchReaderModelData = BatchReaderModelData();
  final String? batch = jsonConvert.convert<String>(json['batch']);
  if (batch != null) {
    batchReaderModelData.batch = batch;
  }
  final String? exp = jsonConvert.convert<String>(json['exp']);
  if (exp != null) {
    batchReaderModelData.exp = exp;
  }
  final String? mrp = jsonConvert.convert<String>(json['mrp']);
  if (mrp != null) {
    batchReaderModelData.mrp = mrp;
  }
  return batchReaderModelData;
}

Map<String, dynamic> $BatchReaderModelDataToJson(BatchReaderModelData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['batch'] = entity.batch;
  data['exp'] = entity.exp;
  data['mrp'] = entity.mrp;
  return data;
}

extension BatchReaderModelDataExtension on BatchReaderModelData {
  BatchReaderModelData copyWith({
    String? batch,
    String? exp,
    String? mrp,
  }) {
    return BatchReaderModelData()
      ..batch = batch ?? this.batch
      ..exp = exp ?? this.exp
      ..mrp = mrp ?? this.mrp;
  }
}