import 'package:scan_and_get_images/generated/json/base/json_field.dart';
import 'package:scan_and_get_images/generated/json/medicine_search_entity.g.dart';
import 'dart:convert';
export 'package:scan_and_get_images/generated/json/medicine_search_entity.g.dart';

@JsonSerializable()
class MedicineSearchEntity {
	@JSONField(name: "status_code")
	String? statusCode;
	@JSONField(name: "status_message")
	String? statusMessage;
	String? datetime;
	@JSONField(name: "ng_version")
	String? ngVersion;
	MedicineSearchData? data;

	MedicineSearchEntity();

	factory MedicineSearchEntity.fromJson(Map<String, dynamic> json) => $MedicineSearchEntityFromJson(json);

	Map<String, dynamic> toJson() => $MedicineSearchEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MedicineSearchData {
	MedicineSearchDataMedicines? medicines;
	List<dynamic>? customers;
	List<dynamic>? distributors;

	MedicineSearchData();

	factory MedicineSearchData.fromJson(Map<String, dynamic> json) => $MedicineSearchDataFromJson(json);

	Map<String, dynamic> toJson() => $MedicineSearchDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MedicineSearchDataMedicines {
	@JSONField(name: "search_type")
	String? searchType;
	@JSONField(name: "did_you_mean_result")
	List<dynamic>? didYouMeanResult;
	List<MedicineSearchDataMedicinesResult>? result;

	MedicineSearchDataMedicines();

	factory MedicineSearchDataMedicines.fromJson(Map<String, dynamic> json) => $MedicineSearchDataMedicinesFromJson(json);

	Map<String, dynamic> toJson() => $MedicineSearchDataMedicinesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MedicineSearchDataMedicinesResult {
	int? approved;
	@JSONField(name: "available_for_patient")
	String? availableForPatient;
	@JSONField(name: "cess_percentage")
	int? cessPercentage;
	@JSONField(name: "requested_by_entity")
	String? requestedByEntity;
	String? content;
	@JSONField(name: "dosage_type")
	String? dosageType;
	@JSONField(name: "gst_percentage")
	int? gstPercentage;
	@JSONField(name: "gtin_number")
	String? gtinNumber;
	@JSONField(name: "hsn_code")
	String? hsnCode;
	String? image;
	@JSONField(name: "manufacturer_name")
	String? manufacturerName;
	@JSONField(name: "medicine_id")
	int? medicineId;
	@JSONField(name: "medicine_name")
	String? medicineName;
	@JSONField(name: "medicine_name_suggest")
	String? medicineNameSuggest;
	@JSONField(name: "medicine_type")
	String? medicineType;
	int? mrp;
	@JSONField(name: "pack_size")
	String? packSize;
	@JSONField(name: "packing_size")
	String? packingSize;
	int? price;
	@JSONField(name: "salt_content_id")
	int? saltContentId;
	@JSONField(name: "schedule_type")
	String? scheduleType;
	int? size;
	String? slug;
	@JSONField(name: "popularity_count")
	int? popularityCount;
	String? location;
	@JSONField(name: "sale_discount")
	int? saleDiscount;
	@JSONField(name: "sale_b2b_discount")
	int? saleB2bDiscount;
	@JSONField(name: "sale_count")
	int? saleCount;
	@JSONField(name: "min_quantity")
	int? minQuantity;
	@JSONField(name: "max_quantity")
	int? maxQuantity;
	@JSONField(name: "lock_discount")
	String? lockDiscount;
	@JSONField(name: "lock_b2b_discount")
	String? lockB2bDiscount;
	@JSONField(name: "sell_in_loose")
	String? sellInLoose;
	String? directions;
	@JSONField(name: "inventory_id")
	int? inventoryId;
	int? quantity;
	String? discontinued;
	@JSONField(name: "added_to_shortbook")
	String? addedToShortbook;
	String? level;

	MedicineSearchDataMedicinesResult();

	factory MedicineSearchDataMedicinesResult.fromJson(Map<String, dynamic> json) => $MedicineSearchDataMedicinesResultFromJson(json);

	Map<String, dynamic> toJson() => $MedicineSearchDataMedicinesResultToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}