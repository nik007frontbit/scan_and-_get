import 'package:scan_and_get_images/generated/json/base/json_convert_content.dart';
import 'package:scan_and_get_images/screen/batch_reader/model/batch_reader_thread_entity.dart';

BatchReaderThreadEntity $BatchReaderThreadEntityFromJson(
    Map<String, dynamic> json) {
  final BatchReaderThreadEntity batchReaderThreadEntity = BatchReaderThreadEntity();
  final int? statusCode = jsonConvert.convert<int>(json['status_code']);
  if (statusCode != null) {
    batchReaderThreadEntity.statusCode = statusCode;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['status_message']);
  if (statusMessage != null) {
    batchReaderThreadEntity.statusMessage = statusMessage;
  }
  final BatchReaderThreadData? data = jsonConvert.convert<
      BatchReaderThreadData>(json['data']);
  if (data != null) {
    batchReaderThreadEntity.data = data;
  }
  return batchReaderThreadEntity;
}

Map<String, dynamic> $BatchReaderThreadEntityToJson(
    BatchReaderThreadEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['data'] = entity.data?.toJson();
  return data;
}

extension BatchReaderThreadEntityExtension on BatchReaderThreadEntity {
  BatchReaderThreadEntity copyWith({
    int? statusCode,
    String? statusMessage,
    BatchReaderThreadData? data,
  }) {
    return BatchReaderThreadEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..data = data ?? this.data;
  }
}

BatchReaderThreadData $BatchReaderThreadDataFromJson(
    Map<String, dynamic> json) {
  final BatchReaderThreadData batchReaderThreadData = BatchReaderThreadData();
  final int? chemistId = jsonConvert.convert<int>(json['chemist_id']);
  if (chemistId != null) {
    batchReaderThreadData.chemistId = chemistId;
  }
  final int? purchaseId = jsonConvert.convert<int>(json['purchase_id']);
  if (purchaseId != null) {
    batchReaderThreadData.purchaseId = purchaseId;
  }
  final int? medicineId = jsonConvert.convert<int>(json['medicine_id']);
  if (medicineId != null) {
    batchReaderThreadData.medicineId = medicineId;
  }
  final String? batch = jsonConvert.convert<String>(json['batch']);
  if (batch != null) {
    batchReaderThreadData.batch = batch;
  }
  return batchReaderThreadData;
}

Map<String, dynamic> $BatchReaderThreadDataToJson(
    BatchReaderThreadData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['chemist_id'] = entity.chemistId;
  data['purchase_id'] = entity.purchaseId;
  data['medicine_id'] = entity.medicineId;
  data['batch'] = entity.batch;
  return data;
}

extension BatchReaderThreadDataExtension on BatchReaderThreadData {
  BatchReaderThreadData copyWith({
    int? chemistId,
    int? purchaseId,
    int? medicineId,
    String? batch,
  }) {
    return BatchReaderThreadData()
      ..chemistId = chemistId ?? this.chemistId
      ..purchaseId = purchaseId ?? this.purchaseId
      ..medicineId = medicineId ?? this.medicineId
      ..batch = batch ?? this.batch;
  }
}