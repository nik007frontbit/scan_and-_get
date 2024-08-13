import 'package:scan_and_get_images/generated/json/base/json_field.dart';
import 'package:scan_and_get_images/generated/json/batch_reader_model_entity.g.dart';
import 'dart:convert';
export 'package:scan_and_get_images/generated/json/batch_reader_model_entity.g.dart';

@JsonSerializable()
class BatchReaderModelEntity {
	@JSONField(name: "status_code")
	int? statusCode;
	@JSONField(name: "status_message")
	String? statusMessage;
	BatchReaderModelData? data;

	BatchReaderModelEntity();

	factory BatchReaderModelEntity.fromJson(Map<String, dynamic> json) => $BatchReaderModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $BatchReaderModelEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BatchReaderModelData {
	String? batch;
	String? exp;
	String? mrp;

	BatchReaderModelData();

	factory BatchReaderModelData.fromJson(Map<String, dynamic> json) => $BatchReaderModelDataFromJson(json);

	Map<String, dynamic> toJson() => $BatchReaderModelDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}