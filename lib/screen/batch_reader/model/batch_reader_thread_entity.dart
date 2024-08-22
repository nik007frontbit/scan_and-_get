import 'package:scan_and_get_images/generated/json/base/json_field.dart';
import 'package:scan_and_get_images/generated/json/batch_reader_thread_entity.g.dart';
import 'dart:convert';
export 'package:scan_and_get_images/generated/json/batch_reader_thread_entity.g.dart';

@JsonSerializable()
class BatchReaderThreadEntity {
	@JSONField(name: "status_code")
	int? statusCode;
	@JSONField(name: "status_message")
	String? statusMessage;
	BatchReaderThreadData? data;

	BatchReaderThreadEntity();

	factory BatchReaderThreadEntity.fromJson(Map<String, dynamic> json) => $BatchReaderThreadEntityFromJson(json);

	Map<String, dynamic> toJson() => $BatchReaderThreadEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BatchReaderThreadData {
	@JSONField(name: "chemist_id")
	int? chemistId;
	@JSONField(name: "purchase_id")
	int? purchaseId;
	@JSONField(name: "medicine_id")
	int? medicineId;
	String? batch;

	BatchReaderThreadData();

	factory BatchReaderThreadData.fromJson(Map<String, dynamic> json) => $BatchReaderThreadDataFromJson(json);

	Map<String, dynamic> toJson() => $BatchReaderThreadDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}