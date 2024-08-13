import 'package:scan_and_get_images/generated/json/base/json_field.dart';
import 'package:scan_and_get_images/generated/json/address_search_model_entity.g.dart';
import 'dart:convert';
export 'package:scan_and_get_images/generated/json/address_search_model_entity.g.dart';

@JsonSerializable()
class AddressSearchModelEntity {
	@JSONField(name: "status_code")
	late String statusCode;
	@JSONField(name: "status_message")
	late String statusMessage;
	late String datetime;
	@JSONField(name: "ng_version")
	late String ngVersion;
	late AddressSearchModelData data;

	AddressSearchModelEntity();

	factory AddressSearchModelEntity.fromJson(Map<String, dynamic> json) => $AddressSearchModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddressSearchModelEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddressSearchModelData {
	@JSONField(name: "search_type")
	late String searchType;
	@JSONField(name: "did_you_mean_result")
	late List<dynamic> didYouMeanResult;
	late List<AddressSearchModelDataResult> result;

	AddressSearchModelData();

	factory AddressSearchModelData.fromJson(Map<String, dynamic> json) => $AddressSearchModelDataFromJson(json);

	Map<String, dynamic> toJson() => $AddressSearchModelDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddressSearchModelDataResult {
	late int approved;
	@JSONField(name: "available_for_patient")
	late String availableForPatient;
	@JSONField(name: "cess_percentage")
	late int cessPercentage;
	@JSONField(name: "requested_by_entity")
	late String requestedByEntity;
	late String content;
	@JSONField(name: "dosage_type")
	late String dosageType;
	@JSONField(name: "gst_percentage")
	late int gstPercentage;
	@JSONField(name: "gtin_number")
	late String gtinNumber;
	@JSONField(name: "hsn_code")
	late String hsnCode;
	late String image;
	@JSONField(name: "manufacturer_name")
	late String manufacturerName;
	@JSONField(name: "medicine_id")
	late int medicineId;
	@JSONField(name: "medicine_name")
	late String medicineName;
	@JSONField(name: "medicine_name_suggest")
	late String medicineNameSuggest;
	@JSONField(name: "medicine_type")
	late String medicineType;
	late int mrp;
	@JSONField(name: "pack_size")
	late String packSize;
	@JSONField(name: "packing_size")
	late String packingSize;
	late int price;
	@JSONField(name: "salt_content_id")
	late int saltContentId;
	@JSONField(name: "schedule_type")
	late String scheduleType;
	late int size;
	late String slug;
	late String location;
	@JSONField(name: "sale_discount")
	late int saleDiscount;
	@JSONField(name: "sale_b2b_discount")
	late int saleB2bDiscount;
	@JSONField(name: "sale_count")
	late int saleCount;
	@JSONField(name: "min_quantity")
	late int minQuantity;
	@JSONField(name: "max_quantity")
	late int maxQuantity;
	@JSONField(name: "lock_discount")
	late String lockDiscount;
	@JSONField(name: "lock_b2b_discount")
	late String lockB2bDiscount;
	@JSONField(name: "sell_in_loose")
	late String sellInLoose;
	late String directions;
	@JSONField(name: "inventory_id")
	late int inventoryId;
	late int quantity;
	late String discontinued;

	AddressSearchModelDataResult();

	factory AddressSearchModelDataResult.fromJson(Map<String, dynamic> json) => $AddressSearchModelDataResultFromJson(json);

	Map<String, dynamic> toJson() => $AddressSearchModelDataResultToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}